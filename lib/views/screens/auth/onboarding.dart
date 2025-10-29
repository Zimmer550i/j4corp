import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/image_picker_widget.dart';
import 'package:j4corp/views/screens/app.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  DateTime? birthDay;

  void onSubmit() async {
    Get.offAll(() => App(), routeName: "/app");
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
                          "Register Your Unit",
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
                      CustomTextField(title: "VIN", hintText: "Enter VIN"),
                      CustomTextField(title: "Brand", hintText: "Enter Brand"),
                      CustomTextField(title: "Model", hintText: "Enter Model"),
                      CustomTextField(title: "Year", hintText: "Enter Year"),
                      CustomDatePicker(
                        title: "Date of Purchase",
                        callBack: (val) {},
                      ),
                      CustomDropDown(
                        title: "Store/Location",
                        options: [
                          "BMW Motorcycles of San Antonio",
                          "BMG Xtreme Sports",
                          "Triumph Houston",
                        ],
                        address: [
                          "BMW Motorcycles of San Antonio",
                          "BMG Xtreme Sports",
                          "Triumph Houston",
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Additional Information",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.gray,
                                ),
                              ),
                              Text(
                                " (Optional)",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.gray.shade300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          CustomTextField(
                            hintText:
                                "Add any important details about the unit",
                            lines: 5,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Additional Information",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.gray,
                                ),
                              ),
                              Text(
                                " (Optional)",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.gray.shade300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ImagePickerWidget(),
                        ],
                      ),
                      const SizedBox(height: 0),
                      CustomButton(onTap: onSubmit, text: "Register Unit"),
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
