import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/screens/settings/my_garage.dart';
import 'package:j4corp/views/screens/settings/profile_information.dart';
import 'package:j4corp/views/screens/settings/scheduled_services.dart';
import 'package:j4corp/views/screens/settings/user_info.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings", hasLeading: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 12,
          children: [
            const SizedBox(height: 4),
            options("personal_information", "Personal Information", () {
              Get.to(() => ProfileInformation());
            }),
            options("services", "Scheduled Services", () {
              Get.to(() => ScheduledServices());
            }),
            options("garage", "My Garage", () {
              Get.to(() => MyGarage());
            }),
            options("terms", "Terms Of Services", () {
              Get.to(() => UserInfo(title: "Terms Of Services", data: ""));
            }),
            options("privacy", "Privacy Policy", () {
              Get.to(() => UserInfo(title: "Privacy Policy", data: ""));
            }),
            options("about", "About Us", () {
              Get.to(() => UserInfo(title: "About Us", data: ""));
            }),
            options("logout", "Logout", () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppColors.gray.shade200,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Logout",
                          style: AppTexts.tlgs.copyWith(
                            color: Color(0xffE25252),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Divider(),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "Are you sure you want to log out?",
                            textAlign: TextAlign.center,
                            style: AppTexts.tlgm,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                onTap: () {},
                                text: "Yes",
                                isSecondary: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                onTap: () {
                                  Get.back();
                                },
                                text: "Cancel",
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  GestureDetector options(
    String iconName,
    String title,
    void Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.gray.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray.shade900,
              ),
              child: Center(
                child: CustomSvg(
                  asset: "assets/icons/$iconName.svg",
                  size: 24,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(title, style: AppTexts.tmdr),
            Spacer(),
            CustomSvg(
              asset: "assets/icons/arrow_right.svg",
              size: 24,
              color: AppColors.gray.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
