import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:j4corp/controllers/service_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_loading.dart';
import 'package:j4corp/views/screens/services.dart';

class ScheduledServices extends StatefulWidget {
  const ScheduledServices({super.key});

  @override
  State<ScheduledServices> createState() => _ScheduledServicesState();
}

class _ScheduledServicesState extends State<ScheduledServices> {
  final service = Get.find<ServiceController>();

  @override
  void initState() {
    super.initState();
    service.fetchServices().then((message) {
      if (message != "success") {
        customSnackbar(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Scheduled Services"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Obx(
            () => service.isLoading.value
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoading(),
                )
                : Column(
                    spacing: 12,
                    children: [
                      const SizedBox(),
                      for (var i in service.services)
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
                              _buildRichTextRow(
                                "Service Date:",
                                DateFormat("dd MMMM, yyyy").format(i.appointmentDate),
                              ),
                              _buildRichTextRow("Unit:", i.modelName),
                              _buildRichTextRow(
                                "Service Description:",
                                i.details,
                              ),
                              const SizedBox(height: 4),
                              CustomButton(
                                onTap: () {
                                  Get.to(() => Services(service: i,));
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
