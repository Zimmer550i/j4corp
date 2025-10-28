import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/screens/auth/verification.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  void onSubmit() async {
    Get.to(() => Verification(isResettingPassword: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff0D0D1B)),
              child: Stack(
                children: [
                  Positioned(
                    right: -80,
                    top: -80,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                      child: CustomSvg(asset: "assets/icons/shade.svg"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () => Get.back(),
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              height: 32,
                              width: 32,
                              child: Center(
                                child: CustomSvg(
                                  asset: "assets/icons/back.svg",
                                  color: AppColors.offWhite,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Forgot Password",
                            style: AppTexts.dsms.copyWith(
                              color: AppColors.offWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    title: "Email",
                    hintText: "Enter your email address",
                  ),
                  const SizedBox(height: 32),
                  CustomButton(onTap: onSubmit, text: "Send OTP"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
