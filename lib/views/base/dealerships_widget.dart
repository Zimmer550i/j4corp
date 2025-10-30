import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DealershipsWidget extends StatelessWidget {
  final String assetName;
  final List<String> urls;
  const DealershipsWidget({
    super.key,
    required this.urls,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gray.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 20,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.gray.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomSvg(asset: "assets/icons/$assetName.svg"),
          ),
          Row(
            children: [
              iconButtons("phone", "Call Us", 0),
              iconButtons("chat", "Chat", 1),
              iconButtons("pin", "Location", 2),
              iconButtons("team", "Team", 4),
            ],
          ),
          CustomButton(onTap: () {}, text: "Leave a Review"),
        ],
      ),
    );
  }

  Expanded iconButtons(String iconName, String title, int pos) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (urls.length >= pos) {
            launchUrl(Uri.parse(urls[pos]));
          }
        },
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.gray[50],
                border: Border.all(color: AppColors.gray.shade700),
                shape: BoxShape.circle,
              ),
              child: CustomSvg(
                asset: "assets/icons/$iconName.svg",
                size: 24,
                color: AppColors.gray.shade900,
              ),
            ),
            Text(title, style: AppTexts.txsm),
          ],
        ),
      ),
    );
  }
}
