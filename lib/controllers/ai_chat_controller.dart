import 'dart:convert';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/models/ai_message_model.dart';
import 'package:j4corp/models/session_model.dart';
import 'package:j4corp/services/ai_api_service.dart';
import 'package:get/get.dart';

class AiChatController extends GetxController {
  final api = AiApiService();
  final user = Get.find<UserController>();

  List<AiMessageModel> messages = RxList.empty();
  RxList<SessionModel> sessions = RxList.empty();
  Rxn<AiMessageModel> temporaryMessage = Rxn();
  RxnString sessionId = RxnString();

  RxBool isLoading = RxBool(false);
  RxBool fetchingChat = RxBool(false);
  RxBool aiReplying = RxBool(false);

  Future<String> getSessions() async {
    fetchingChat(true);
    try {
      final response = await api.get("/sessions/${user.userData!.userId}");
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        sessions.clear();

        for (var i in body['sessions']) {
          sessions.add(SessionModel.fromJson(i));
        }

        return "success";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      fetchingChat(false);
    }
  }

  Future<String> getSessionHistory(String id) async {
    fetchingChat(true);
    try {
      sessionId.value = id;
      final response = await api.get("/chat/$id/history");
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        messages.clear();
        for (var i in body['messages']) {
          messages.add(AiMessageModel.fromJson(i));
        }

        return "success";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      fetchingChat(false);
    }
  }

  Future<String> deleteSession(String id) async {
    int index = sessions.indexWhere((val) => val.sessionId == id);
    final temp = sessions.removeAt(index);
    sessions.remove(temp);
    try {
      final response = await api.delete(
        "/sessions/$id?user_id=${user.userData!.userId}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        sessionId.value = sessions.isNotEmpty ? sessions.first.sessionId : null;
        return "success";
      } else {
        sessions.insert(index, temp);
        return "Something went wrong";
      }
    } catch (e) {
      sessions.insert(index, temp);
      return e.toString();
    }
  }

  Future<String> createSession() async {
    fetchingChat(true);
    try {
      final response = await api.post(
        "/sessions?user_id=${user.userData!.userId}&title=New%20Chat",
        {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        sessionId.value = jsonDecode(response.body)['session_id'];
        messages.clear();
        return "success";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      fetchingChat(false);
    }
  }

  Future<String> renameSession(String id, String name) async {
    final index = sessions.indexWhere((s) => s.sessionId == id);
    final prevName = sessions[index].title;
    if (index != -1) {
      sessions[index] = sessions[index].copyWith(title: name);
    }
    try {
      final response = await api.put("/sessions/update_title", {
        "session_id": id,
        "title": name,
        "user_id": "${user.userData!.userId}",
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "success";
      } else {
        sessions[index] = sessions[index].copyWith(title: prevName);
        return "Something went wrong";
      }
    } catch (e) {
      sessions[index] = sessions[index].copyWith(title: prevName);
      return e.toString();
    }
  }

  Future<String> sendMessage(String message) async {
    aiReplying(true);
    try {
      addMessage(message, "user", sessionId.value);
      final response = await api.post("/chat", {
        "message": message,
        "session_id": sessionId.value,
        "user_id": "${user.userData!.userId}",
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        addMessage(body['response'], "assistant", body['session_id']);

        return "success";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      aiReplying(false);
    }
  }

  void addMessage(String message, String role, String? session) {
    messages.add(
      AiMessageModel(role: role, content: message, timestamp: DateTime.now()),
    );
  }

  // void addMessage(String message, String role, String? session) {
  //   // If it's a new chat keep it temporarily
  //   if (session == null) {
  //     temporaryMessage.value = AiMessageModel(
  //       role: role,
  //       content: message,
  //       timestamp: DateTime.now(),
  //     );

  //     return;
  //   }

  //   if (messages.containsKey(session)) {
  //     messages[session]!.add(
  //       AiMessageModel(role: role, content: message, timestamp: DateTime.now()),
  //     );
  //   } else {
  //     if (temporaryMessage.value != null) {
  //       messages.addAll({
  //         session: [temporaryMessage.value!],
  //       });
  //       temporaryMessage.value = null;
  //       sessionId.value = session;
  //     }

  //     messages.addAll({
  //       session: [
  //         AiMessageModel(role: role, content: message, timestamp: DateTime.now()),
  //       ],
  //     });
  //   }
  // }
}
