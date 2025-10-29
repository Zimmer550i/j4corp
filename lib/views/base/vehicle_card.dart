import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddUnit(isExisting: true));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.gray.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          spacing: 12,
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Image.asset("assets/images/bike.jpg"),
            ),
            Column(
              spacing: 8,
              children: [
                _buildRichTextRow("Make: ", "BMW"),
                _buildRichTextRow("Model: ", "G0310R"),
                _buildRichTextRow("Year: ", "2025"),
                _buildRichTextRow("VIN: ", "1HGBH41JXMN109186"),
                _buildRichTextRow("Date of Purchase: ", "11 January 2025"),
                _buildRichTextRow("Store of Purchase: ", "BMG Xtreme Sports"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichTextRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppTexts.tsmr.copyWith(color: AppColors.gray.shade700),
          ),
          TextSpan(
            text: " $value",
            style: AppTexts.tsmm.copyWith(color: AppColors.gray.shade900),
          ),
        ],
      ),
    );
  }
}
