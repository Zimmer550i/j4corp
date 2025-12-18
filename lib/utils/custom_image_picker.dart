import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:j4corp/utils/app_colors.dart';

Future<File?> customImagePicker({
  isCircular = true,
  isSquared = true,
  ImageSource source = ImageSource.gallery,
}) async {
  final picker = ImagePicker();
  final cropper = ImageCropper();

  final XFile? pickedImage = await picker.pickImage(
    source: source,
  );

  if (pickedImage != null) {
    final CroppedFile? croppedImage = await cropper.cropImage(
      sourcePath: pickedImage.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop your image',
          toolbarColor: AppColors.black,
          toolbarWidgetColor: Colors.blue[50],
          backgroundColor: AppColors.black,
          statusBarColor: AppColors.blue,
          cropStyle: isCircular ? CropStyle.circle : CropStyle.rectangle,
          hideBottomControls: isSquared,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          cropStyle: isCircular ? CropStyle.circle : CropStyle.rectangle,
          showCancelConfirmationDialog: true,
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    }
  }

  return null;
}
