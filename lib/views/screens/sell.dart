import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_text_field.dart';
import 'package:j4corp/views/base/unit_drop_down.dart';
import 'package:j4corp/views/base/vehicle_card.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  final unit = Get.find<UnitController>();
  final info = TextEditingController();

  Unit? selected;

  void onSubmit() async {
    final message = await unit.sellUnit(selected!.id, info.text);

    if (message == "success") {
      setState(() {
        selected = null;
        info.clear();
      });
      customSnackbar("Your unit is up to sell!", isError: false);
    } else {
      customSnackbar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sell Us Your Bike", hasLeading: false),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(),
                UnitDropDown(
                  onChanged: (val) {
                    setState(() {
                      selected = val;
                    });
                  },
                  hintText: "Select a unit to sell",
                ),

                if (selected != null) VehicleCard(selected!),

                if (selected != null)
                  CustomTextField(
                    title: "Additional Information",
                    controller: info,
                    hintText: "Say something about this product",
                    lines: 5,
                  ),
                if (selected != null)
                  Obx(
                    () => CustomButton(
                      onTap: onSubmit,
                      text: "Submit",
                      isLoading: unit.isLoading.value,
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
