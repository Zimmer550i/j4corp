import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class UnitDropDown extends StatelessWidget {
  final void Function(Unit)? onChanged;
  final int? selectedUnit;
  final String hintText;
  const UnitDropDown({
    super.key,
    this.selectedUnit,
    this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unit = Get.find<UnitController>();
      if (unit.units.isEmpty) {
        unit.getUnits().then((message) {
          if (message != "success") {
            customSnackbar(message);
          }
        });
      }

      String? pickedOption = unit.units
          .firstWhere((val) => val.id == selectedUnit)
          .model;
      return CustomDropDown(
        onChanged: (val) {
          final selectedUnit = unit.units.elementAt(val);
          if (onChanged != null) onChanged!(selectedUnit);
        },
        addNewCallback: () {
          Get.to(() => AddUnit());
        },
        pickedOption: pickedOption,
        isLoading: unit.isLoading.value,
        options: unit.units.map((val) => val.model).toList(),
        hintText: hintText,
        title: "Select Unit",
      );
    });
  }
}
