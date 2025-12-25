import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_loading.dart';
import 'package:j4corp/views/base/vehicle_card.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class MyGarage extends StatefulWidget {
  const MyGarage({super.key});

  @override
  State<MyGarage> createState() => _MyGarageState();
}

class _MyGarageState extends State<MyGarage> {
  final unit = Get.find<UnitController>();

  @override
  void initState() {
    super.initState();
    unit.getUnits().then((message) {
      if (message != "success") {
        customSnackbar(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Garage"),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Obx(
                () => Column(
                  spacing: 12,
                  children: [
                    const SizedBox(),
                    if (unit.isLoading.value) CustomLoading(),
                    if (unit.units.isEmpty && !unit.isLoading.value)
                      Center(
                        child: Text(
                          "No Vehicles in your garange",
                          style: TextStyle(fontSize: 12, color: AppColors.gray),
                        ),
                      ),
                    if (!unit.isLoading.value)
                      for (var i in unit.units) VehicleCard(i),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              child: CustomButton(
                onTap: () {
                  Get.to(() => AddUnit());
                },
                text: "Add Unit",
                leading: "assets/icons/plus.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
