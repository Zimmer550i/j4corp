import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class UnitDropDown extends StatelessWidget {
  final void Function(int)? onChanged;
  final String hintText;
  const UnitDropDown({super.key, this.onChanged, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unit = Get.find<UnitController>();
      return CustomDropDown(
        onChanged: (val) {
          final selectedUnit = unit.units.elementAt(val);
          if (onChanged != null) onChanged!(selectedUnit.id);
        },
        addNewCallback: () {
          Get.to(() => AddUnit());
        },
        isLoading: unit.isLoading.value,
        options: unit.units.map((val) => val.model).toList(),
        hintText: hintText,
        title: "Select Unit",
      );
    });
  }
}
