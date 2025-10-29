import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/base/custom_text_field.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int? servicedBefore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Schedule Service", hasLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              CustomDropDown(
                options: [
                  "Kawasaki-KLX110R",
                  "Kawasaki-KLX110R",
                  "Kawasaki-KLX110R",
                ],
                title: "Select Unit",
              ),
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
              CustomDatePicker(
                callBack: (val) {},
                title: "Appointment Date",
              ),
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
              CustomButton(text: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
