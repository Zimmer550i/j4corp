import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/screens/auth/login.dart';
import 'package:j4corp/views/screens/auth/verification.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  DateTime? birthDay;

  void onSubmit() async {
    Get.to(() => Verification());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                              "Register",
                              style: AppTexts.dsms.copyWith(
                                color: AppColors.offWhite,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              spacing: 4,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: AppTexts.txsm.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAll(() => Login());
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: AppTexts.txss.copyWith(
                                      color: AppColors.blue.shade500,
                                    ),
                                  ),
                                ),
                              ],
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
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            title: "First Name",
                            hintText: "Enter first name",
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            title: "Last Name",
                            hintText: "Enter last name",
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      title: "Email",
                      hintText: "Enter your email address",
                    ),
                    CustomTextField(
                      title: "Phone",
                      hintText: "Enter your phone number",
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      title: "Address",
                      hintText: "Enter your address",
                    ),
                    CustomTextField(
                      title: "ZIP Code",
                      hintText: "Enter your ZIP/Postal Code",
                    ),
                    CustomDatePicker(
                      title: "Birthday",
                      date: birthDay,
                      callBack: (date) {
                        setState(() {
                          birthDay = date;
                        });
                      },
                    ),
                    CustomTextField(
                      title: "New Password",
                      hintText: "Generate a new password",
                      isPassword: true,
                    ),
                    CustomTextField(
                      title: "Confirm Password",
                      hintText: "Enter the new password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 0),
                    CustomButton(onTap: onSubmit, text: "Register"),
                    const SizedBox(height: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
