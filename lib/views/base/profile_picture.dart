import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:j4corp/utils/custom_image_picker.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String? image;
  final File? imageFile;
  final bool showLoading;
  final bool isEditable;
  final Color? borderColor;
  final double borderWidth;
  final Function(File)? imagePickerCallback;

  const ProfilePicture({
    super.key,
    this.image,
    this.size = 100,
    this.showLoading = true,
    this.isEditable = false,
    this.imagePickerCallback,
    this.imageFile,
    this.borderColor,
    this.borderWidth = 0,
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
            padding: EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
              color: borderColor,
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
                        return Shimmer.fromColors(
                          baseColor: AppColors.green.shade300,
                          highlightColor: AppColors.green[25]!,
                          period: Duration(milliseconds: 800),
                          child: Container(
                            height: size,
                            width: size,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          width: size,
                          height: size,
                          color: AppColors.green[100],
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
                        border: Border.all(color: AppColors.green[300]!),
                      ),
                      child: Center(child: Icon(Icons.error)),
                    ),
            ),
          ),
          if (isEditable)
            Positioned(
              left: 0,
              right: 0,
              bottom: -12,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: CustomSvg(
                    asset: "assets/icons/edit.svg",
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
