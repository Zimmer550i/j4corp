import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/views/base/custom_networked_image.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class VehicleCard extends StatelessWidget {
  final Unit unit;
  const VehicleCard(this.unit, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddUnit(unit: unit));
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
              child: CustomNetworkedImage(url: unit.image),
            ),
            Column(
              spacing: 8,
              children: [
                _buildRichTextRow("Make: ", unit.brand),
                _buildRichTextRow("Model: ", unit.model),
                _buildRichTextRow("Year: ", unit.year.toString()),
                _buildRichTextRow("VIN: ", unit.vin),
                _buildRichTextRow(
                  "Date of Purchase: ",
                  DateFormat("dd MMMM yyyy").format(unit.purchaseDate),
                ),
                _buildRichTextRow("Store of Purchase: ", unit.storeLocation),
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
