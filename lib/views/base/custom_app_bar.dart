import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  final Widget? trailing;
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasLeading = true,
    this.trailing,
  });

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: SizedBox(
        height: 44,
        child: Row(
          children: [
            SizedBox(width: 12),
            InkWell(
              onTap: () => hasLeading ? Get.back() : null,
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 32,
                width: 32,
                child: hasLeading
                    ? Center(child: CustomSvg(asset: "assets/icons/back.svg"))
                    : const SizedBox(),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTexts.tmdm.copyWith(color: AppColors.gray.shade900),
              ),
            ),
            const SizedBox(width: 18),
            trailing ?? const SizedBox(width: 32),
            const SizedBox(width: 12),
          ],
        ),
      ),
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(0.5),
      //   child: Container(
      //     height: 0.5,
      //     width: double.infinity,
      //     color: AppColors.indigo.shade300,
      //   ),
      // ),
    );
  }
}
