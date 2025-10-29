import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/vehicle_card.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class MyGarage extends StatelessWidget {
  const MyGarage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Garage"),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                spacing: 12,
                children: [
                  const SizedBox(),
                  for (int i = 0; i < 10; i++) VehicleCard(),
                  const SizedBox(height: 70),
                ],
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
