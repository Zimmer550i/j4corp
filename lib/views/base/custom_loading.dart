import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;
  const CustomLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? AppColors.gray.shade900),
    );
  }
}
