import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/chat_controller.dart';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/models/message_model.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_loading.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final chat = Get.find<ChatController>();
  final text = TextEditingController();
  final userId = Get.find<UserController>().userData!.userId;

  List<Widget> messages = [];
  FocusNode focusNode = FocusNode();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    chat.initChat();

    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      chat.fetchMessages(loadNext: true);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    chat.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: CustomSvg(asset: "assets/icons/back.svg", size: 24),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(width: 8),
            Text("Jimenez Motorsports", style: AppTexts.tmdm),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                minimum: EdgeInsets.only(bottom: 20),
                bottom: false,
                child: Obx(
                  () => Column(
                    children: [
                      if (chat.isLoading.value)
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomLoading(),
                        ),
                      for (int i = 0; i < chat.messages.length; i++)
                        getMessages(i),
                    ],
                  ),
                ),
              ),
            ),
          ),
          inputField(),
        ],
      ),
    );
  }

  Container inputField() {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray.shade200)),
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: text,
              maxLines: 3,
              cursorColor: AppColors.gray.shade900,
              onTapOutside: (event) {
                setState(() {
                  focusNode.unfocus();
                });
              },
              style: AppTexts.tsmm.copyWith(color: AppColors.gray.shade900),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: "Write your message",
                hintStyle: AppTexts.tsmr.copyWith(
                  color: AppColors.gray.shade300,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (text.text.trim() != "") {
                chat.sendMessage(text: text.text);
                text.clear();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gray.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Send",
                style: AppTexts.tsmm.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMessages(int i) {
    int messageLength = chat.messages.length;

    MessageModel message = chat.messages.elementAt(i);
    MessageModel? prevMessage = i != 0 ? chat.messages.elementAt(i - 1) : null;
    MessageModel? nextMessage = i < messageLength - 1
        ? chat.messages.elementAt(i + 1)
        : null;

    if (message.senderId == userId) {
      return sendMessage(
        message.text,
        hasNext: nextMessage != null && nextMessage.senderId == userId,
        hasPrev: prevMessage != null && prevMessage.senderId == userId,
        isRead: message.isRead,
        isTemp: message.id == -1,
      );
    } else {
      return recieveMessage(
        message.text,
        hasNext: nextMessage != null && nextMessage.senderId != userId,
        hasPrev: prevMessage != null && prevMessage.senderId != userId,
      );
    }
  }

  Widget recieveMessage(
    String? messgae, {
    bool hasPrev = false,
    bool hasNext = false,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: hasPrev ? 4 : 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.gray.shade100,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(hasPrev ? 10 : 0),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (!hasPrev)
                Positioned(
                  left: -15.73,
                  top: -4,
                  child: Transform.flip(
                    flipX: true,
                    child: CustomSvg(
                      asset: "assets/icons/chat_pointer.svg",
                      color: AppColors.gray.shade100,
                    ),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      messgae ?? "",
                      style: AppTexts.tsmr.copyWith(
                        color: AppColors.gray.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "3:33 PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.gray.shade300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendMessage(
    String? messgae, {
    bool hasPrev = false,
    bool hasNext = false,
    bool isRead = false,
    bool isTemp = false,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(top: hasPrev ? 4 : 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.gray.shade900,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(hasPrev ? 10 : 0),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (!hasPrev)
                Positioned(
                  right: -15.73,
                  top: -4,
                  child: CustomSvg(
                    asset: "assets/icons/chat_pointer.svg",
                    color: AppColors.gray.shade900,
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      messgae ?? "",
                      style: AppTexts.tsmr.copyWith(color: Color(0xffE6FEFB)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "3:33 PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.gray.shade400,
                    ),
                  ),
                  if (!isTemp)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CustomSvg(
                        asset: "assets/icons/sent.svg",
                        color: isRead ? AppColors.blue : AppColors.gray,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
