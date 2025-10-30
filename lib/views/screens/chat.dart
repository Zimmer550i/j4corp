import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Widget> messages = [];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    getMessages();
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                minimum: EdgeInsets.only(bottom: 20),
                bottom: false,
                child: Column(children: messages),
              ),
            ),
          ),
          Container(
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
                    maxLines: 3,
                    cursorColor: AppColors.gray.shade900,
                    onTapOutside: (event) {
                      setState(() {
                        focusNode.unfocus();
                      });
                    },
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
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
                Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getMessages() {
    messages.clear();
    messages.addAll([
      recieveMessage("Hey, do you know what time is it where you are?"),
      sendMessage("t’s morning in Tokyo 😎"),
      recieveMessage("What does it look like in Japan?", hasNext: true),
      recieveMessage("Do you like it?", hasPrev: true),
      sendMessage("Absolutely loving it!", hasNext: true),
      recieveMessage("Hey, do you know what time is it where you are?"),
      sendMessage("t’s morning in Tokyo 😎"),
      recieveMessage("What does it look like in Japan?", hasNext: true),
      recieveMessage("Do you like it?", hasPrev: true),
      sendMessage("Absolutely loving it!", hasNext: true),
      recieveMessage("Hey, do you know what time is it where you are?"),
      sendMessage("t’s morning in Tokyo 😎"),
      recieveMessage("What does it look like in Japan?", hasNext: true),
      recieveMessage("Do you like it?", hasPrev: true),
      sendMessage("Absolutely loving it!", hasNext: true),
      recieveMessage("Hey, do you know what time is it where you are?"),
      sendMessage("t’s morning in Tokyo 😎"),
      recieveMessage("What does it look like in Japan?", hasNext: true),
      recieveMessage("Do you like it?", hasPrev: true),
      sendMessage("Absolutely loving it!", hasNext: true),
      recieveMessage("Hey, do you know what time is it where you are?"),
      sendMessage("t’s morning in Tokyo 😎"),
      recieveMessage("What does it look like in Japan?", hasNext: true),
      recieveMessage("Do you like it?", hasPrev: true),
      sendMessage("Absolutely loving it!", hasNext: true),
      recieveMessage("Hey, do you know what time is it where you are?"),
      sendMessage("t’s morning in Tokyo 😎"),
      recieveMessage("What does it look like in Japan?", hasNext: true),
      recieveMessage("Do you like it?", hasPrev: true),
      sendMessage("Absolutely loving it!", hasNext: true),
    ]);
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
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CustomSvg(asset: "assets/icons/sent.svg"),
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
