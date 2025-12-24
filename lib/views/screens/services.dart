import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/service_controller.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/models/service.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/location_drop_down.dart';
import 'package:j4corp/views/base/unit_drop_down.dart';

class Services extends StatefulWidget {
  final Service? service;
  const Services({super.key, this.service});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final service = Get.find<ServiceController>();
  final details = TextEditingController();

  DateTime? date;
  String? location;
  Unit? selectedUnit;
  bool servicedBefore = false;

  @override
  void initState() {
    super.initState();
    if (widget.service != null) populate();
  }

  void onSubmit() async {
    if (date == null || location == null || selectedUnit == null) {
      customSnackbar("Please fill-in the informations");
      return;
    }
    late String message;
    if (widget.service == null) {
      message = await service.createService(
        selectedUnit!.id,
        details.text,
        location!,
        date!,
        servicedBefore,
      );
    } else {
      message = await service.updateService(
        widget.service!.id,
        selectedUnit!.id,
        details.text,
        location!,
        date!,
        servicedBefore,
      );
    }

    if (message == "success") {
      if (widget.service == null) {
        setState(() {
          selectedUnit = null;
          date = null;
          location = null;
          servicedBefore = false;
          details.text = "";
        });
        customSnackbar("Your service has been scheduled", isError: false);
      } else {
        if (mounted) Get.back();
        customSnackbar("Your service has been updated", isError: false);
      }
    } else {
      customSnackbar(message);
    }
  }

  void populate() {
    selectedUnit = Get.find<UnitController>().units.firstWhereOrNull(
      (val) => val.id == widget.service!.unit,
    );
    date = widget.service!.appointmentDate;
    details.text = widget.service!.details;
    location = widget.service!.location;
    servicedBefore = widget.service!.hasServicedBefore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.service != null
            ? "Edit Scheduled Service"
            : "Schedule Service",
        hasLeading: widget.service != null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              UnitDropDown(
                onChanged: (val) {
                  setState(() {
                    selectedUnit = val;
                  });
                },
                selectedUnit: selectedUnit?.id,
                hintText: "Select the unit you want service on",
              ),
              CustomTextField(
                controller: details,
                title: "What service do you need?",
                hintText: "Accessory Installation",
                lines: 5,
              ),
              LocationDropDown(
                onChanged: (val) {
                  setState(() {
                    location = val;
                  });
                },
                initial: location,
                hintText: "Select where you want the service",
              ),
              CustomDatePicker(
                callBack: (val) {
                  setState(() {
                    date = val;
                  });
                },
                date: date,
                title: "Appointment Date",
              ),
              Text(
                "Have we serviced your vehicle before?",
                style: AppTexts.txsm.copyWith(color: AppColors.gray),
              ),
              Row(
                spacing: 20,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        servicedBefore = true;
                      });
                    },
                    child: Row(
                      spacing: 4,
                      children: [
                        CustomSvg(
                          asset:
                              "assets/icons/radio${servicedBefore ? "_selected" : ""}.svg",
                        ),
                        Text(
                          "Yes",
                          style: AppTexts.tlgr.copyWith(
                            color: AppColors.gray.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        servicedBefore = false;
                      });
                    },
                    child: Row(
                      spacing: 4,
                      children: [
                        CustomSvg(
                          asset:
                              "assets/icons/radio${!servicedBefore ? "_selected" : ""}.svg",
                        ),
                        Text(
                          "No",
                          style: AppTexts.tlgr.copyWith(
                            color: AppColors.gray.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              widget.service != null
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return cancelApointmentDialog();
                                },
                              );
                            },
                            isSecondary: true,
                            padding: 0,
                            text: "Cancel Appointment",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              onTap: onSubmit,
                              isLoading: service.isLoading.value,
                              text: "Save Changes",
                              padding: 0,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Obx(
                      () => CustomButton(
                        onTap: onSubmit,
                        isLoading: service.isLoading.value,
                        text: "Submit",
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Material cancelApointmentDialog() {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Cancel",
                  style: AppTexts.tlgs.copyWith(color: Color(0xffE25252)),
                ),
                const SizedBox(height: 16),
                Text(
                  "Are you sure you want to cancel the Scheduled Service",
                  style: AppTexts.tmdm,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomButton(
                          onTap: () async {
                            final message = await service.deleteService(
                              widget.service!.id,
                            );
                            if (message == "success") {
                              if (mounted) {
                                Get.back(closeOverlays: true);
                              }
                              customSnackbar(
                                "Appointment deleted successfully",
                                isError: false,
                              );
                            } else {
                              customSnackbar(message);
                            }
                          },
                          isSecondary: true,
                          isLoading: service.isDeleting.value,
                          padding: 0,
                          text: "Yes, Cancel",
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(onTap: () => Get.back(), text: "No"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
