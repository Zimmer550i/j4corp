import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  final ImagePicker _imagePicker = ImagePicker();

  ImagePickerWidget({super.key});

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        Get.find<UnitController>().selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        Get.find<UnitController>().selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture image: $e');
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
                onTap: _pickImageFromCamera,
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
