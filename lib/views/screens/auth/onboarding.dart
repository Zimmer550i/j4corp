import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_date_picker.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/image_picker_widget.dart';
import 'package:j4corp/views/screens/app.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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

    if (unitController.selectedImage.value == null) {
      Get.snackbar("Error", "Please select an image");
      return;
    }

    final message = await unitController.createUnit(
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

    if (message == "success") {
      customSnackbar("Your unit has been added to your Garage", isError: false);
      Get.offAll(() => App(), routeName: "/app");
    } else {
      customSnackbar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xff0D0D1B)),
            child: Stack(
              children: [
                Positioned(
                  right: -80,
                  top: -80,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                    child: CustomSvg(asset: "assets/icons/shade.svg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () => Get.back(),
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: Center(
                              child: CustomSvg(
                                asset: "assets/icons/back.svg",
                                color: AppColors.offWhite,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Register Your Unit",
                          style: AppTexts.dsms.copyWith(
                            color: AppColors.offWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
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
                            selectedStore = value;
                          });
                        },
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Additional Information",
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.gray,
                                ),
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
                            hintText:
                                "Add any important details about the unit",
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
                                style: AppTexts.txsm.copyWith(
                                  color: AppColors.gray,
                                ),
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
                          ImagePickerWidget(),
                        ],
                      ),
                      const SizedBox(height: 0),
                      Obx(
                        () => CustomButton(
                          onTap: onSubmit,
                          text: "Register Unit",
                          isLoading: unitController.isLoading.value,
                        ),
                      ),
                      const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
