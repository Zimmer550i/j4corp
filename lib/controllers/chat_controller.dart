import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/models/chat_model.dart';
import 'package:j4corp/models/message_model.dart';
import 'package:j4corp/services/api_service.dart';
import 'package:j4corp/services/shared_prefs_service.dart';
import 'package:j4corp/utils/custom_snackbar.dart';

class ChatController extends GetxController {
  final api = ApiService();

  RxBool isConnected = RxBool(false);
  WebSocket? socket;
  final _wsBaseUrl = "ws://10.10.12.111:8000";
  final _adminId = "1";
  int? _roomId;
  late String _token;
  bool isTyping = false;

  Rxn<ChatModel> chatRoom = Rxn();
  RxList<MessageModel> messages = RxList.empty();

  RxBool isLoading = RxBool(false);
  RxnInt next = RxnInt();

  int reconnectCount = 0;
  final int maxReconnectAttempts = 10;
  final Duration reconnectDelay = const Duration(seconds: 3);

  void initChat() async {
    if (isConnected.value) {
      markAsRead();
      _initWebSocket();
    } else {
      if (chatRoom.value == null) {
        createOrGetChat().then((message) {
          if (message == "success") {
            fetchMessages();
            _initWebSocket();
          } else {
            customSnackbar(message);
          }
        });
      } else {
        _initWebSocket();
      }
    }
  }

  void endChat() {}

  /// ⚙️ Initializes the WebSocket connection
  Future<void> _initWebSocket() async {
    try {
      // Get token from API service
      _token = await SharedPrefsService.get('token') ?? "";
      reconnectCount += 1;
      final wsUrl = "$_wsBaseUrl/ws/chat/$_roomId/?token=$_token";
      debugPrint('🔌 Connecting to WebSocket: $wsUrl');

      socket?.close();
      socket = await WebSocket.connect(wsUrl);
      isConnected.value = true;
      debugPrint('✅ WebSocket Connected');

      // Listen for incoming messages
      _setupWebSocketListeners();
    } catch (e) {
      debugPrint('❌ WebSocket connection error: $e');
      isConnected.value = false;
    }
  }

  /// 👂 Setup listeners for WebSocket messages
  void _setupWebSocketListeners() {
    socket?.listen(
      (data) {
        try {
          final jsonData = jsonDecode(data);
          final type = jsonData['type'];

          switch (type) {
            case 'message':
              _handleIncomingMessage(jsonData);
              break;
            case 'error':
              debugPrint('❌ Server error: ${jsonData['error']}');
              break;
            default:
              debugPrint('⚠️ Unknown message type: $type');
          }
        } catch (e) {
          debugPrint('Error parsing WebSocket message: $e, Data: $data');
        }
      },
      onError: (error) {
        debugPrint('❌ WebSocket error: $error');
        isConnected.value = false;
        _scheduleReconnect();
      },
      onDone: () {
        debugPrint('🔌 WebSocket disconnected');
        isConnected.value = false;
      },
    );
  }

  void _scheduleReconnect() {
    if (reconnectCount >= maxReconnectAttempts) {
      debugPrint('🚫 Max reconnect attempts reached');
      return;
    }

    reconnectCount++;
    debugPrint(
      '🔁 Reconnecting in ${reconnectDelay.inSeconds}s (Attempt $reconnectCount)',
    );

    Future.delayed(reconnectDelay, () {
      if (!isConnected.value) {
        _initWebSocket();
      }
    });
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    try {
      final messageData = data['message'];
      final message = MessageModel.fromJson(messageData);

      // Remove demo message if exists
      if (messages.isNotEmpty && messages.last.id == -1) {
        messages.removeLast();
      }

      messages.add(message);
      debugPrint("📩 New message received: ${message.text}");
    } catch (e) {
      debugPrint('Error parsing message: $e');
    }
  }

  void sendMessage({required String text}) {
    if (socket == null || !isConnected.value) {
      debugPrint(
        "⚠️ Cannot send message: WebSocket is not connected or initialized.",
      );
      return;
    }

    // Add message to local list immediately (optimistic update)
    final tempMessage = MessageModel(
      id: -1,
      room: _roomId ?? 0,
      senderId: Get.find<UserController>().userData!.userId,
      senderInfo: SenderInfo(
        userId: Get.find<UserController>().userData!.userId,
        firstName: '',
        lastName: '',
        email: '',
      ),
      text: text,
      attachmentType: 'none',
      createdAt: DateTime.now(),
      isRead: false,
    );

    messages.add(tempMessage);
    messages.refresh();

    // Send to server
    final payload = {"action": "send", "text": text};

    socket?.add(jsonEncode(payload));
    debugPrint('📤 Message sent: $text');
  }

  /// Mark message as read
  Future<String> markAsRead() async {
    try {
      final response = await api.post("v1/chat/messages/mark-read/", {
        "room_id": _roomId,
      }, authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        messages = RxList.from(
          messages.map((val) => val.isRead = true).toList(),
        );
        return "success";
      } else {
        return body['message'] ?? "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Close WebSocket connection
  void closeConnection() {
    socket?.close();
    isConnected.value = false;
    debugPrint('🔌 WebSocket connection closed');
  }

  Future<String> createOrGetChat() async {
    isLoading(true);
    try {
      final res = await api.post("v1/chat/rooms/create/", {
        "other_user_id": _adminId,
      }, authReq: true);
      final body = jsonDecode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final room = body['room'];

        chatRoom.value = ChatModel.fromJson(room);
        _roomId = chatRoom.value!.id;

        return "success";
      } else {
        return body['message'] ?? "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> fetchMessages({bool loadNext = false}) async {
    if (loadNext && next.value == null) return "success";
    if (isLoading.value) return "success";
    isLoading(true);
    try {
      final res = await api.get(
        "v1/chat/rooms/$_roomId/messages/",
        queryParams: loadNext && next.value != null
            ? {"page": next.value.toString()}
            : null,
        authReq: true,
      );

      final body = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (!loadNext) {
          messages.clear();
          final List<dynamic> dataList = body['results'];
          final newItems = dataList
              .map((e) => MessageModel.fromJson(e))
              .toList();
          messages.addAll(newItems);
        } else {
          for (var i in body['results']) {
            messages.insert(0, MessageModel.fromJson(i));
          }
        }

        next.value = body['next'];

        return "success";
      } else {
        return body['message'] ?? "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }
}
