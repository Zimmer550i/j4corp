import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/auth_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/screens/auth/onboarding.dart';
import 'package:j4corp/views/screens/auth/reset_password.dart';
import 'package:pinput/pinput.dart';

class Verification extends StatefulWidget {
  final bool isResettingPassword;
  final String email;
  const Verification({
    super.key,
    this.isResettingPassword = false,
    required this.email,
  });

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final auth = Get.find<AuthController>();
  final ctrl = TextEditingController();

  void onSubmit() async {
    final message = await auth.verifyOtp(
      ctrl.text,
      isResettingPass: widget.isResettingPassword,
    );

    if (message == "success") {
      if (widget.isResettingPassword) {
        Get.to(() => ResetPassword());
      } else {
        Get.back();
        Get.back();
        Get.to(() => Onboarding());
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
                            "Verify Email",
                            style: AppTexts.dsms.copyWith(
                              color: AppColors.offWhite,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                "OTP has been sent to your Email",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.isResettingPassword) {
                                    auth.forgetPassword(widget.email).then((
                                      message,
                                    ) {
                                      if (message == "success") {
                                        customSnackbar(
                                          "OTP has been sent to ${widget.email}",
                                        );
                                      } else {
                                        customSnackbar(message);
                                      }
                                    });
                                  } else {
                                    auth.resendOtp(widget.email).then((
                                      message,
                                    ) {
                                      if (message == "success") {
                                        customSnackbar(
                                          "OTP has been sent to ${widget.email}",
                                        );
                                      } else {
                                        customSnackbar(message);
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  "Resend",
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
                children: [
                  Pinput(
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    controller: ctrl,
                    defaultPinTheme: PinTheme(
                      height: 46,
                      width: 46,
                      textStyle: AppTexts.tsmm,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.gray.shade100),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Color(0x3dE4E5E7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => CustomButton(
                      onTap: onSubmit,
                      isLoading: auth.isLoading.value,
                      text: "Verify",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
