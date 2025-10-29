import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/utils/system_ui_utils.dart';
import 'package:j4corp/views/base/profile_picture.dart';
import 'package:j4corp/views/screens/settings/edit_profile.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  void initState() {
    super.initState();
    setStatusBarLightIcons();
  }

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
                    PopupMenuButton(
                      icon: CustomSvg(
                        asset: "assets/icons/three_dot.svg",
                        size: 24,
                      ),
                      padding: EdgeInsets.zero,
                      menuPadding: EdgeInsets.zero,
                      color: AppColors.white,
                      onSelected: (value) {
                        Get.to(() => EditProfile());
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: "bla bla",
                            child: Row(
                              children: [
                                CustomSvg(
                                  asset: "assets/icons/edit.svg",
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Edit Profile",
                                  style: AppTexts.tlgr.copyWith(
                                    color: AppColors.gray.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
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
                ),
              ),
            ],
          ),

          SizedBox(height: (MediaQuery.of(context).size.width / 9) + 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ralph Edwards", style: AppTexts.dsmr),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CustomSvg(
                      asset: "assets/icons/mail.svg",
                      color: AppColors.gray.shade900,
                    ),
                    const SizedBox(width: 12),
                    Text("debbie.baker@example.com", style: AppTexts.tmdr),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CustomSvg(
                      asset: "assets/icons/phone.svg",
                      color: AppColors.gray.shade900,
                    ),
                    const SizedBox(width: 12),
                    Text("(252) 555-0126", style: AppTexts.tmdr),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CustomSvg(
                      asset: "assets/icons/pin.svg",
                      size: 24,
                      color: AppColors.gray.shade900,
                    ),
                    const SizedBox(width: 12),
                    Text("Fairfield", style: AppTexts.tmdr),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CustomSvg(
                      asset: "assets/icons/cake.svg",
                      color: AppColors.gray.shade900,
                    ),
                    const SizedBox(width: 12),
                    Text("12/06/1999", style: AppTexts.tmdr),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
