import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gray.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSvg(
                      asset: "assets/icons/upload.svg",
                      color: AppColors.gray.shade300,
                      size: 36,
                    ),
                    Text(
                      "Select file",
                      style: AppTexts.tmdr.copyWith(
                        color: AppColors.gray.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 100, width: 1, color: AppColors.gray.shade300),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSvg(
                      asset: "assets/icons/camera.svg",
                      color: AppColors.gray.shade300,
                      size: 36,
                    ),
                    Text(
                      "Capture",
                      style: AppTexts.tmdr.copyWith(
                        color: AppColors.gray.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
