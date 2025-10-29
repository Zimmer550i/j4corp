import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/profile_picture.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime? birthDay;

  void onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.gray.shade900),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: CustomSvg(
                      asset: "assets/icons/profile_decoration.svg",
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: Center(
                          child: CustomSvg(
                            asset: "assets/icons/back.svg",
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        "Personal Information",
                        textAlign: TextAlign.center,
                        style: AppTexts.tmdm.copyWith(color: AppColors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SizedBox(width: 48),
                    const SizedBox(width: 2),
                  ],
                ),
              ),
              Positioned(
                bottom: -MediaQuery.of(context).size.width / 9,
                left:
                    (MediaQuery.of(context).size.width / 2) -
                    (MediaQuery.of(context).size.width / 6),
                child: ProfilePicture(
                  image: "https://thispersondoesnotexist.com",
                  size: MediaQuery.of(context).size.width / 3,
                  isEditable: true,
                ),
              ),
            ],
          ),
          SizedBox(height: (MediaQuery.of(context).size.width / 9)),
          Expanded(
            child: SingleChildScrollView(
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
                      const SizedBox(height: 0),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onTap: () => Get.back(),
                              isSecondary: true,
                              text: "Cancel",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomButton(onTap: onSubmit, text: "Save"),
                          ),
                        ],
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
