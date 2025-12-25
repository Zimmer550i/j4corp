import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/ai_chat_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_loading.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  final ai = Get.find<AiChatController>();
  final controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ai.createSession().then((message) {
      if (message != "success") {
        customSnackbar(message);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (ai.messages.isEmpty && ai.sessionId.value != null) {
      ai.deleteSession(ai.sessionId.value!);
    }
  }

  void onSend() async {
    final message = controller.text;
    controller.clear();
    await ai.sendMessage(message).then((val) {
      if (val != "success") {
        Get.snackbar("Error occured", val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final showTyping = ai.aiReplying.value;
      final messages = ai.messages;
      return Column(
        children: [
          ai.fetchingChat.value
              ? Expanded(child: CustomLoading())
              : Expanded(
                  child: ai.messages.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I can check the availability of products or vehicles. What would you like to look for?",
                                textAlign: TextAlign.center,
                                style: AppTexts.tmdr.copyWith(
                                  color: AppColors.gray.shade300,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: messages.length + (showTyping ? 1 : 0),
                          itemBuilder: (context, index) {
                            // Typing indicator at top (because reverse: true)
                            if (showTyping && index == 0) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                                child: TypingIndicator(),
                              );
                            }

                            // Adjust index if typing indicator exists
                            final messageIndex = showTyping ? index - 1 : index;
                            final message =
                                messages[messages.length - 1 - messageIndex];

                            final isSender = message.role == "user";

                            return Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: index == 0 ? 16 : 0,
                              ),
                              child: chatText(message.content, isSender),
                            );
                          },
                        ),
                ),
          inputField(autoFocus: !ai.fetchingChat.value),
        ],
      );
    });
  }

  Widget chatText(String message, bool isSender, {bool isLoading = false}) {
    return Row(
      spacing: 12,
      mainAxisAlignment: isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (isSender) const SizedBox(width: 20),
        Flexible(
          child: isSender
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.gray.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    message,
                    style: AppTexts.txsr.copyWith(
                      color: AppColors.gray.shade600,
                    ),
                  ),
                )
              : MarkdownBody(
                  data: message,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    p: AppTexts.txsr.copyWith(color: AppColors.gray.shade600),
                    strong: AppTexts.txsb.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                    listBullet: AppTexts.txsr.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ),
        ),
        if (!isSender) const SizedBox(width: 20),
      ],
    );
  }

  Widget inputField({bool autoFocus = false}) {
    return SafeArea(
      child: Container(
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
                autofocus: autoFocus,
                focusNode: _focusNode,
                controller: controller,
                maxLines: 3,
                cursorColor: AppColors.gray.shade900,
                onTapOutside: (event) {
                  setState(() {
                    _focusNode.unfocus();
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
                ai.sendMessage(controller.text.trim());
                controller.clear();
                _focusNode.unfocus();
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
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> dotOneAnim;
  late Animation<double> dotTwoAnim;
  late Animation<double> dotThreeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    dotOneAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
          ),
        );
    dotTwoAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.75, curve: Curves.easeInOut),
          ),
        );
    dotThreeAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget dot(Animation<double> animation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, -animation.value),
          child: child,
        ),
        child: CircleAvatar(
          radius: 4,
          backgroundColor: AppColors.gray.shade300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [dot(dotOneAnim), dot(dotTwoAnim), dot(dotThreeAnim)],
    );
  }
}
