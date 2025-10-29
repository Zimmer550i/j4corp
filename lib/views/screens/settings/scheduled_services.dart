import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/screens/services.dart';

class ScheduledServices extends StatefulWidget {
  const ScheduledServices({super.key});

  @override
  State<ScheduledServices> createState() => _ScheduledServicesState();
}

class _ScheduledServicesState extends State<ScheduledServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Scheduled Services"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            spacing: 12,
            children: [
              const SizedBox(),
              for (int i = 0; i < 10; i++)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.gray.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRichTextRow("Service Date:", "January 1, 2025"),
                      _buildRichTextRow("Unit:", "Honda Civic"),
                      _buildRichTextRow("Service Description:", "Oil Change"),
                      const SizedBox(height: 4),
                      CustomButton(
                        onTap: () {
                          Get.to(() => Services(existingService: true));
                        },
                        text: "View Details",
                      ),
                    ],
                  ),
                ),

              const SizedBox(),
            ],
          ),
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
