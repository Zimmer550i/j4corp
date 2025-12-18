import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/auth_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
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
  final auth = Get.find<AuthController>();
  DateTime? birthDay;

  // Text editing controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController zipCodeController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    zipCodeController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (birthDay == null) {
      Get.snackbar("Error", "Please select a birthday");
      return;
    }

    final message = await auth.register(
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      phoneController.text,
      addressController.text,
      zipCodeController.text,
      birthDay!,
      passwordController.text,
      confirmPasswordController.text,
    );

    if (message == "success") {
      customSnackbar("OTP has been sent to ${emailController.text}");
      Get.to(() => Verification(email: emailController.text));
    } else {
      customSnackbar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: SafeArea(
                top: false,
                child: Padding(
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
                              controller: firstNameController,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              title: "Last Name",
                              hintText: "Enter last name",
                              controller: lastNameController,
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        title: "Email",
                        hintText: "Enter your email address",
                        controller: emailController,
                      ),
                      CustomTextField(
                        title: "Phone",
                        hintText: "Enter your phone number",
                        textInputType: TextInputType.number,
                        controller: phoneController,
                      ),
                      CustomTextField(
                        title: "Address",
                        hintText: "Enter your address",
                        controller: addressController,
                      ),
                      CustomTextField(
                        title: "ZIP Code",
                        hintText: "Enter your ZIP/Postal Code",
                        controller: zipCodeController,
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
                        controller: passwordController,
                      ),
                      CustomTextField(
                        title: "Confirm Password",
                        hintText: "Enter the new password",
                        isPassword: true,
                        controller: confirmPasswordController,
                      ),
                      const SizedBox(height: 0),
                      Obx(
                        () => CustomButton(
                          onTap: onSubmit,
                          isLoading: auth.isLoading.value,
                          text: "Register",
                        ),
                      ),
                      const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
