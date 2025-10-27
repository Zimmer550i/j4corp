import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:template/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/utils/custom_image_picker.dart';
import 'package:template/utils/custom_svg.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String? image;
  final File? imageFile;
  final bool showLoading;
  final bool isEditable;
  final Function(File)? imagePickerCallback;

  const ProfilePicture({
    super.key,
    this.image,
    this.size = 100,
    this.showLoading = true,
    this.isEditable = false,
    this.imagePickerCallback,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (!isEditable) {
          return;
        }

        File? image = await customImagePicker();

        if (image != null && imagePickerCallback != null) {
          imagePickerCallback!(image);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.gray.shade100,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    )
                  : image != null
                  ? CachedNetworkImage(
                      imageUrl: image!,
                      progressIndicatorBuilder: (context, url, progress) {
                        return SizedBox(
                          width: size,
                          height: size,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              strokeWidth: 2,
                              color: AppColors.blue[400],
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          width: size,
                          height: size,
                          color: AppColors.blue[100],
                          child: Icon(Icons.error, color: Colors.blue),
                        );
                      },
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: size,
                      height: size,
                      padding: EdgeInsets.all(size * 0.17),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.blue[300]!),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/bell.svg",
                          colorFilter: ColorFilter.mode(
                            AppColors.blue[400]!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (isEditable)
            Positioned(
              left: 0,
              right: 0,
              bottom: -12,
              child: Center(
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white),
                  ),

                  child: Center(
                    child: CustomSvg(
                      asset: "assets/icons/edit.svg",
                      size: 16,
                      color: AppColors.white,
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
