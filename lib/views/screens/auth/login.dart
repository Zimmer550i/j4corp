import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/auth_controller.dart';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/screens/auth/forgot_password.dart';
import 'package:j4corp/views/screens/auth/onboarding.dart';
import 'package:j4corp/views/screens/auth/signup.dart';
import 'package:j4corp/views/screens/auth/verification.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = Get.find<AuthController>();

  final emailController = TextEditingController(text: "wasiul0491@gmail.com");
  final passController = TextEditingController(text: "wasiul12");
  bool rememberMe = true;

  void onSubmit() async {
    final message = await auth.login(
      emailController.text,
      passController.text,
      rememberMe,
    );

    if (message == "success") {
      if (Get.find<UserController>().userData!.isVerified) {
        Get.to(() => Onboarding());
        // Get.offAll(() => App(), routeName: "/app");
      } else {
        customSnackbar("Please verify your email to proceed");
        auth.resendOtp(emailController.text).then((val) {
          if (val == "success") {
            customSnackbar("OTP has been sent to ${emailController.text}");
          } else {
            customSnackbar(val);
          }
        });
        Get.to(() => Verification(email: emailController.text));
      }
    } else {
      customSnackbar(message);
    }
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
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign in to your Account",
                            style: AppTexts.dsms.copyWith(
                              color: AppColors.offWhite,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => Signup());
                                },
                                child: Text(
                                  "Sign Up",
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
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    CustomTextField(
                      title: "Email",
                      controller: emailController,
                      hintText: "Enter your email address",
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: "Password",
                      controller: passController,
                      isPassword: true,
                      hintText: "Enter your password",
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: rememberMe,
                            onChanged: (val) {
                              setState(() {
                                rememberMe = val ?? false;
                              });
                            },
                            focusColor: AppColors.blue,
                            activeColor: AppColors.gray.shade900,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.gray,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ForgotPassword(email: emailController.text),
                            );
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => CustomButton(
                        onTap: onSubmit,
                        isLoading: auth.isLoading.value,
                        text: "Log In",
                      ),
                    ),
                    Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "By signing up, you agree to the",
                        style: AppTexts.txsr,
                        children: [
                          TextSpan(
                            text: " Terms of Service ",
                            style: AppTexts.txss,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(text: "and"),
                          TextSpan(
                            text: " Data Processing Agreement",
                            style: AppTexts.txss,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
