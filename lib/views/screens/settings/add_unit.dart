import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/image_picker_widget.dart';

class AddUnit extends StatefulWidget {
  final bool isExisting;
  const AddUnit({super.key, this.isExisting = false});

  @override
  State<AddUnit> createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  DateTime? birthDay;

  void onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.isExisting ? "Edit Unit" : "Add Unit"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            spacing: 16,
            children: [
              const SizedBox(),
              CustomTextField(title: "VIN", hintText: "Enter VIN"),
              CustomTextField(title: "Brand", hintText: "Enter Brand"),
              CustomTextField(title: "Model", hintText: "Enter Model"),
              CustomTextField(title: "Year", hintText: "Enter Year"),
              CustomDatePicker(title: "Date of Purchase", callBack: (val) {}),
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
                        style: AppTexts.txsm.copyWith(color: AppColors.gray),
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
                    hintText: "Add any important details about the unit",
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
                        style: AppTexts.txsm.copyWith(color: AppColors.gray),
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
              widget.isExisting
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Material(
                                    type: MaterialType.transparency,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 24,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Delete",
                                                style: AppTexts.tlgs.copyWith(
                                                  color: Color(0xffE25252),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                "Are you sure you want to delete the Unit?",
                                                style: AppTexts.tmdm,
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 24),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomButton(
                                                      onTap: () => Get.back(),
                                                      isSecondary: true,
                                                      text: "Yes, Delete",
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: CustomButton(
                                                      onTap: () => Get.back(),
                                                      text: "No",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            isSecondary: true,
                            padding: 0,
                            text: "Delete",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            onTap: onSubmit,
                            text: "Save Changes",
                            padding: 0,
                          ),
                        ),
                      ],
                    )
                  : CustomButton(onTap: onSubmit, text: "Confirm"),
              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
