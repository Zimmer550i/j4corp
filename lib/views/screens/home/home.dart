import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/dealerships_widget.dart';
import 'package:j4corp/views/base/profile_picture.dart';
import 'package:j4corp/views/screens/home/ai_assistant.dart';
import 'package:j4corp/views/screens/home/notifications.dart';
import 'package:j4corp/views/screens/settings/my_garage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            ProfilePicture(
              image: "https://thispersondoesnotexist.com",
              size: 36,
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                text: "Hi, ",
                style: AppTexts.tlgr.copyWith(color: AppColors.gray),
                children: [
                  TextSpan(
                    text: "Jenny",
                    style: AppTexts.tlgm.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Get.to(() => Notifications());
              },
              child: const SizedBox(
                height: 40,
                width: 40,
                child: Center(child: CustomSvg(asset: "assets/icons/bell.svg")),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => AiAssistant());
              },
              child: CustomSvg(
                asset: "assets/icons/assistant.svg",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Get.to(() => MyGarage());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.gray.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    CustomSvg(asset: "assets/icons/garage.svg", size: 28),
                    const SizedBox(height: 8),
                    Text(
                      "My Garage",
                      style: AppTexts.tmdr.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Our Dealerships", style: AppTexts.tmdr),
            ),
            const SizedBox(height: 12),
            DealershipsWidget(assetName: "bmw", urls: ["tel:01825067298"]),
            const SizedBox(height: 16),
            DealershipsWidget(assetName: "triumph", urls: []),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
