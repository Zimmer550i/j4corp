import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.item,
    required this.showBoarder,
  });

  final Map<String, dynamic> item;
  final bool showBoarder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.blue[50],
        borderRadius: BorderRadius.circular(8),
        // border: showBoarder
        //     ? Border(bottom: BorderSide(color: AppColors.gray[100]!))
        //     : null,
      ),
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gray[50],
            ),
            child: Center(
              child: CustomSvg(
                asset: "assets/icons/bell.svg",
                color: AppColors.gray.shade900,
                size: 24,
              ),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['text'],
                  style: AppTexts.tsmr.copyWith(color: AppColors.gray.shade900),
                ),
                Row(
                  spacing: 2,
                  children: [
                    CustomSvg(asset: "assets/icons/clock.svg"),
                    Text(
                      "5 min ago",
                      style: AppTexts.txsr.copyWith(color: AppColors.gray, height: 1.2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
