import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';

customSnackbar(
  String message, {
  bool isError = true,
  bool isDarkBackground = false,
}) async {
  Get.snackbar(
    isError ? "Error" : "Success",
    message,
    colorText: isDarkBackground ? Colors.white : AppColors.gray.shade900,
    // backgroundColor: isDarkBackground
  );
}
