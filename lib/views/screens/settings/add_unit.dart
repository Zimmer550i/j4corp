import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/image_picker_widget.dart';

class AddUnit extends StatefulWidget {
  final Unit? unit;
  const AddUnit({super.key, this.unit});

  @override
  State<AddUnit> createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  final unitController = Get.find<UnitController>();

  DateTime? purchaseDate;
  String? selectedStore;
  File? image;

  // Text editing controllers
  late TextEditingController vinController;
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController yearController;
  late TextEditingController additionalNotesController;

  @override
  void initState() {
    super.initState();
    vinController = TextEditingController();
    brandController = TextEditingController();
    modelController = TextEditingController();
    yearController = TextEditingController();
    additionalNotesController = TextEditingController();
    if (widget.unit != null) fillupData();
  }

  @override
  void dispose() {
    vinController.dispose();
    brandController.dispose();
    modelController.dispose();
    yearController.dispose();
    additionalNotesController.dispose();
    super.dispose();
  }

  void fillupData() {
    vinController.text = widget.unit!.vin;
    brandController.text = widget.unit!.brand;
    modelController.text = widget.unit!.model;
    yearController.text = widget.unit!.year.toString();
    additionalNotesController.text = widget.unit!.additionalNotes ?? "";
    selectedStore = widget.unit!.storeLocation;
    purchaseDate = widget.unit!.purchaseDate;
  }

  void onSubmit() async {
    if (vinController.text.isEmpty ||
        vinController.text.length < 11 ||
        vinController.text.length > 25) {
      Get.snackbar("Error", "VIN must be between 11 and 25 characters");
      return;
    }

    if (brandController.text.isEmpty) {
      Get.snackbar("Error", "Please enter brand");
      return;
    }

    if (modelController.text.isEmpty) {
      Get.snackbar("Error", "Please enter model");
      return;
    }

    if (yearController.text.isEmpty) {
      Get.snackbar("Error", "Please enter year");
      return;
    }
    if (int.tryParse(yearController.text) == null) {
      Get.snackbar("Error", "Year must be a valid number");
      return;
    }

    if (purchaseDate == null) {
      Get.snackbar("Error", "Please select a purchase date");
      return;
    }

    if (selectedStore == null || selectedStore!.isEmpty) {
      Get.snackbar("Error", "Please select a store/location");
      return;
    }
    late String message;

    if (widget.unit == null) {
      message = await unitController.createUnit(
        vin: vinController.text,
        brand: brandController.text,
        model: modelController.text,
        year: yearController.text,
        purchaseDate:
            "${purchaseDate!.year.toString()}-${purchaseDate!.month.toString()}-${purchaseDate!.day.toString()}",
        storeLocation: selectedStore!,
        additionalNotes: additionalNotesController.text,
        image: image,
      );
    } else {
      message = await unitController.updateUnit(
        id: widget.unit!.id,
        vin: vinController.text,
        brand: brandController.text,
        model: modelController.text,
        year: yearController.text,
        purchaseDate:
            "${purchaseDate!.year.toString()}-${purchaseDate!.month.toString()}-${purchaseDate!.day.toString()}",
        storeLocation: selectedStore!,
        additionalNotes: additionalNotesController.text,
        image: image,
      );
    }

    if (message == "success") {
      Get.back();
      customSnackbar(
        "Your unit has been ${widget.unit == null ? "added to your Garage" : "updated!"}",
        isError: false,
      );
    } else {
      customSnackbar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.unit != null ? "Edit Unit" : "Add Unit",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            spacing: 16,
            children: [
              const SizedBox(),
              CustomTextField(
                title: "VIN",
                hintText: "Enter VIN",
                controller: vinController,
              ),
              CustomTextField(
                title: "Brand",
                hintText: "Enter Brand",
                controller: brandController,
              ),
              CustomTextField(
                title: "Model",
                hintText: "Enter Model",
                controller: modelController,
              ),
              CustomTextField(
                title: "Year",
                hintText: "Enter Year",
                controller: yearController,
              ),
              CustomDatePicker(
                title: "Date of Purchase",
                date: purchaseDate,
                callBack: (val) {
                  setState(() {
                    purchaseDate = val;
                  });
                },
              ),
              CustomDropDown(
                title: "Store/Location",
                hintText: widget.unit?.storeLocation,
                options: [
                  "BMW Motorcycles of San Antonio",
                  "BMG Xtreme Sports",
                  "Triumph Houston",
                ],
                address: [
                  "BMW Motorcycles of San Antonio",
                  "BMG Xtreme Sports",
                  "Triumph Houston",
                ],
                onChanged: (value) {
                  setState(() {
                    selectedStore = [
                      "BMW Motorcycles of San Antonio",
                      "BMG Xtreme Sports",
                      "Triumph Houston",
                    ][value];
                  });
                },
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Additional Information",
                        style: AppTexts.txsm.copyWith(color: AppColors.gray),
                      ),
                      Text(
                        " (Optional)",
                        style: AppTexts.txsm.copyWith(
                          color: AppColors.gray.shade300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    hintText: "Add any important details about the unit",
                    lines: 5,
                    controller: additionalNotesController,
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Unit Image",
                        style: AppTexts.txsm.copyWith(color: AppColors.gray),
                      ),
                      Text(
                        " (Optional)",
                        style: AppTexts.txsm.copyWith(
                          color: AppColors.gray.shade300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ImagePickerWidget(
                    currentImage: widget.unit?.image,
                    onChanged: (val) {
                      setState(() {
                        image = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 0),
              widget.unit != null
                  ? Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return deleteConfirmation();
                                },
                              );
                            },
                            isSecondary: true,
                            padding: 0,
                            text: "Delete",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              onTap: onSubmit,
                              isLoading: unitController.isLoading.value,
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
                        isLoading: unitController.isLoading.value,
                        text: "Confirm",
                      ),
                    ),
              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

  Material deleteConfirmation() {
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
                  "Delete",
                  style: AppTexts.tlgs.copyWith(color: Color(0xffE25252)),
                ),
                const SizedBox(height: 16),
                Text(
                  "Are you sure you want to delete the Unit?",
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
                            final message = await unitController.deleteUnit(
                              widget.unit!.id,
                            );

                            if (message == "success") {
                              if (mounted) {
                                Get.back();
                                Get.back();
                              }
                              customSnackbar(
                                "Unit has been deleted!",
                                isError: false,
                              );
                            } else {
                              customSnackbar(message);
                            }
                          },
                          isLoading: unitController.isDeleting.value,
                          isSecondary: true,
                          text: "Yes, Delete",
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
