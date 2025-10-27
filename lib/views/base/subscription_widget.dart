import 'package:template/utils/app_colors.dart';
import 'package:template/utils/app_icons.dart';
import 'package:template/utils/app_texts.dart';
import 'package:template/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final List<String> pros;
  final List<String> cons;
  final bool isPurchased;
  final bool isPremium;
  final Function()? onTap;
  const SubscriptionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.pros = const [],
    this.cons = const [],
    this.isPurchased = false,
    this.isPremium = false,
    this.onTap,
  });

  SubscriptionWidget copyWith({
    String? icon,
    String? title,
    String? subTitle,
    List<String>? pros,
    List<String>? cons,
    bool? isPurchased,
    Function()? onTap,
  }) {
    return SubscriptionWidget(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      pros: pros ?? this.pros,
      cons: cons ?? this.cons,
      isPurchased: isPurchased ?? this.isPurchased,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black.shade400,
        borderRadius: BorderRadius.circular(16),
        border: isPurchased ? Border.all(color: AppColors.blue) : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35, right: 35, top: 24, bottom: 20),
            child: Row(
              spacing: 16,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(child: SvgPicture.asset(icon)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTexts.tlgm.copyWith(
                        color: isPremium
                            ? AppColors.black[50]
                            : AppColors.black.shade200,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: AppTexts.tlgm.copyWith(
                        color: isPremium ? AppColors.blue : AppColors.black[50],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 0.5, width: double.infinity, color: AppColors.blue),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  "Features",
                  style: AppTexts.tmdm.copyWith(color: AppColors.black[50]),
                ),
                ...pros.map((e) {
                  return Row(
                    spacing: 8,
                    children: [
                      SvgPicture.asset(AppIcons.tickCircle),
                      Text(
                        e,
                        style: AppTexts.tmdm.copyWith(
                          color: AppColors.black[100],
                        ),
                      ),
                    ],
                  );
                }),
                ...cons.map((e) {
                  return Row(
                    spacing: 8,
                    children: [
                      SvgPicture.asset(AppIcons.closeCircle),
                      Text(
                        e,
                        style: AppTexts.tmdm.copyWith(
                          color: AppColors.black[100],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomButton(
              text: isPurchased ? "Current Plan" : "Choose Plan",
              leading: isPurchased ? AppIcons.tickCircle : null,
              isSecondary: isPurchased,
              onTap: isPurchased ? null : onTap,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
