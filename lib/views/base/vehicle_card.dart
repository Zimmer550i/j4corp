import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Row(
                spacing: 4,
                children: [
                  Text(
                    "Make:",
                    style: AppTexts.tsmr.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                  ),
                  Text(
                    "BMW",
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Text(
                    "Model:",
                    style: AppTexts.tsmr.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                  ),
                  Text(
                    "G0310R",
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Text(
                    "Year:",
                    style: AppTexts.tsmr.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                  ),
                  Text(
                    "2025",
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Text(
                    "VIN:",
                    style: AppTexts.tsmr.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                  ),
                  Text(
                    "1HGBH41JXMN109186",
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Text(
                    "Date of Purchase:",
                    style: AppTexts.tsmr.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                  ),
                  Text(
                    "11 January 2025",
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4,
                children: [
                  Text(
                    "Store of Purchase:",
                    style: AppTexts.tsmr.copyWith(
                      color: AppColors.gray.shade700,
                    ),
                  ),
                  Text(
                    "BMG Xtreme Sports",
                    style: AppTexts.tsmm.copyWith(
                      color: AppColors.gray.shade900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
