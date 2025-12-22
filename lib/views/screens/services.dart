import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/models/service.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/unit_drop_down.dart';

class Services extends StatefulWidget {
  final Service? service;
  const Services({super.key, this.service});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int? servicedBefore;

  void onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.service != null
            ? "Edit Scheduled Service"
            : "Schedule Service",
        hasLeading: widget.service != null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              UnitDropDown(hintText: "hintText"),
              CustomTextField(
                title: "What service do you need?",
                hintText: "Accessory Installation",
                lines: 5,
              ),
              CustomDropDown(
                title: "Select Location",
                hintText: "Select where you want the service",
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
              CustomDatePicker(callBack: (val) {}, title: "Appointment Date"),
              Text(
                "Have we serviced your vehicle before?",
                style: AppTexts.txsm.copyWith(color: AppColors.gray),
              ),
              Row(
                spacing: 20,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        servicedBefore = 0;
                      });
                    },
                    child: Row(
                      spacing: 4,
                      children: [
                        CustomSvg(
                          asset:
                              "assets/icons/radio${servicedBefore == 0 ? "_selected" : ""}.svg",
                        ),
                        Text(
                          "Yes",
                          style: AppTexts.tlgr.copyWith(
                            color: AppColors.gray.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        servicedBefore = 1;
                      });
                    },
                    child: Row(
                      spacing: 4,
                      children: [
                        CustomSvg(
                          asset:
                              "assets/icons/radio${servicedBefore == 1 ? "_selected" : ""}.svg",
                        ),
                        Text(
                          "No",
                          style: AppTexts.tlgr.copyWith(
                            color: AppColors.gray.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              widget.service != null
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
                                                "Cancel",
                                                style: AppTexts.tlgs.copyWith(
                                                  color: Color(0xffE25252),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                "Are you sure you want to cancel the Scheduled Service",
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
                                                      text: "Yes, Cancel",
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
                            text: "Cancel Appointment",
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
                  : CustomButton(onTap: onSubmit, text: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
