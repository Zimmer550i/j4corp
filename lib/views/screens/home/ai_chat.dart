import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:flutter/material.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  List<String> messages = [];
  final FocusNode _focusNode = FocusNode();

  void addMessages() {
    setState(() {
      messages = [
        "Hi! Can you check if a brake pad for a 2018 Toyota Corolla is available?",
        "Sure! Let me check... ✅ Yes, we have the brake pad in stock. There are 3 units available at the main branch.",
        "Great! What about an air filter for the same model?",
        "The air filter for the 2018 Toyota Corolla is currently out of stock. It's expected to arrive by tomorrow evening.",
        "Can you notify me when it arrives?",
        "Absolutely! I’ve set a reminder to notify you once the air filter is back in stock.",
        "Thanks! Also, do you have spark plugs for a Honda Civic 2020?",
        "Checking... 🔍 Yes, we have spark plugs for the 2020 Honda Civic. 5 units are available at the main branch.",
        "Perfect! Can you reserve one for me?",
        "Sure! One spark plug has been reserved for you. Please collect it within 24 hours.",
        "Hi! Can you check if a brake pad for a 2018 Toyota Corolla is available?",
        "Sure! Let me check... ✅ Yes, we have the brake pad in stock. There are 3 units available at the main branch.",
        "Great! What about an air filter for the same model?",
        "The air filter for the 2018 Toyota Corolla is currently out of stock. It's expected to arrive by tomorrow evening.",
        "Can you notify me when it arrives?",
        "Absolutely! I’ve set a reminder to notify you once the air filter is back in stock.",
        "Thanks! Also, do you have spark plugs for a Honda Civic 2020?",
        "Checking... 🔍 Yes, we have spark plugs for the 2020 Honda Civic. 5 units are available at the main branch.",
        "Perfect! Can you reserve one for me?",
        "Sure! One spark plug has been reserved for you. Please collect it within 24 hours.",
      ];
      messages = messages.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
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
                  itemCount: messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    bool isSender = index % 2 != 0;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: index == messages.length - 1 ? 16 : 0,
                      ),
                      child: chatText(messages[index], isSender),
                    );
                  },
                ),
        ),
        inputField(),
      ],
    );
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
              : Text(
                  message,
                  style: AppTexts.txsr.copyWith(color: AppColors.gray),
                ),
        ),
        if (!isSender) const SizedBox(width: 20),
      ],
    );
  }

  Padding newChat() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ask me anything about your course, crypto terms, or how Web3 works",
            textAlign: TextAlign.center,
            style: AppTexts.tlgr.copyWith(color: AppColors.gray.shade400),
          ),
        ],
      ),
    );
  }

  Widget inputField() {
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
                focusNode: _focusNode,
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
                addMessages();
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
            curve: const Interval(0.0, 0.33, curve: Curves.easeInOut),
          ),
        );
    dotTwoAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.33, 0.66, curve: Curves.easeInOut),
          ),
        );
    dotThreeAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.66, 1.0, curve: Curves.easeInOut),
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
        child: const CircleAvatar(radius: 4, backgroundColor: Colors.white70),
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
