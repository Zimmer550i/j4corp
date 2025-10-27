import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_colors.dart';
import 'package:template/utils/app_icons.dart';
import 'package:template/utils/app_texts.dart';
import 'package:template/utils/custom_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;
  const CustomAppBar({super.key, required this.title, this.hasLeading = true});

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.black[600],
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
                    ? Center(child: CustomSvg(asset: AppIcons.back))
                    : const SizedBox(),
              ),
            ),
            const SizedBox(width: 18),
            Text(
              title,
              style: AppTexts.tsmr.copyWith(color: AppColors.black[50]),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          width: double.infinity,
          color: AppColors.black.shade300,
        ),
      ),
    );
  }
}
