import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_image_picker.dart';
import 'package:j4corp/utils/custom_svg.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(File?)? onChanged;
  final String? currentImage;
  const ImagePickerWidget({super.key, this.onChanged, this.currentImage});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? file;

  Future<void> _pickImageFromGallery() async {
    file = await customImagePicker(isCircular: false, isSquared: false);
    setState(() {});

    if (widget.onChanged != null) {
      widget.onChanged!(file);
    }
  }

  Future<void> _pickImageFromCamera() async {
    file = await customImagePicker(
      isCircular: false,
      isSquared: false,
      source: ImageSource.camera,
    );
    setState(() {});

    if (widget.onChanged != null) {
      widget.onChanged!(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gray.shade100,
          borderRadius: BorderRadius.circular(12),
          image: file != null
              ? DecorationImage(image: FileImage(file!), fit: BoxFit.cover)
              : widget.currentImage != null
              ? DecorationImage(
                  image: NetworkImage(widget.currentImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _pickImageFromGallery,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSvg(
                      asset: "assets/icons/upload.svg",
                      color: (file != null || widget.currentImage != null)
                          ? Colors.white
                          : AppColors.gray.shade300,
                      size: 36,
                    ),
                    Text(
                      "Select file",
                      style: AppTexts.tmdr.copyWith(
                        color: (file != null || widget.currentImage != null)
                            ? Colors.white
                            : AppColors.gray.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              width: 1,
              color: (file != null || widget.currentImage != null)
                  ? Colors.white
                  : AppColors.gray.shade300,
            ),
            Expanded(
              child: InkWell(
                onTap: _pickImageFromCamera,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomSvg(
                      asset: "assets/icons/camera.svg",
                      color: (file != null || widget.currentImage != null)
                          ? Colors.white
                          : AppColors.gray.shade300,
                      size: 36,
                    ),
                    Text(
                      "Capture",
                      style: AppTexts.tmdr.copyWith(
                        color: (file != null || widget.currentImage != null)
                            ? Colors.white
                            : AppColors.gray.shade300,
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
