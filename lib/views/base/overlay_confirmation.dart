import 'package:template/utils/app_colors.dart';
import 'package:template/views/base/custom_button.dart';
import 'package:flutter/material.dart';

class OverlayConfirmation extends StatelessWidget {
  final String title;
  final String? highlight;
  final String? buttonTextLeft;
  final String? buttonTextRight;
  final void Function()? buttonCallBackLeft;
  final void Function()? buttonCallBackRight;
  final bool leftButtonIsSecondary;

  const OverlayConfirmation({
    super.key,
    required this.title,
    this.highlight,
    this.buttonTextLeft,
    this.buttonTextRight,
    this.buttonCallBackLeft,
    this.buttonCallBackRight,
    this.leftButtonIsSecondary = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: AppColors.blue[50],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff4b4b4b),
              fontVariations: [FontVariation("wght", 400)],
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          if (highlight != null)
            Text(
              highlight!,
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 20,
                fontVariations: [FontVariation("wght", 600)],
              ),
            ),
          const SizedBox(height: 20),
          Row(
            spacing: 12,
            children: [
              if (buttonTextLeft != null)
                Expanded(
                  child: CustomButton(
                    text: buttonTextLeft!,
                    isSecondary: leftButtonIsSecondary,
                    onTap: buttonCallBackLeft,
                  ),
                ),
              if (buttonTextRight != null)
                Expanded(
                  child: CustomButton(
                    text: buttonTextRight!,
                    isSecondary: !leftButtonIsSecondary,
                    onTap: buttonCallBackRight,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
