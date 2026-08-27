import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/unit_controller.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/utils/custom_snackbar.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';
import 'package:j4corp/views/screens/settings/add_unit.dart';

class UnitDropDown extends StatefulWidget {
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
  State<UnitDropDown> createState() => _UnitDropDownState();
}

class _UnitDropDownState extends State<UnitDropDown> {
  final unit = Get.find<UnitController>();
  String? pickedOption;

  @override
  void initState() {
    super.initState();
    if (unit.units.isEmpty) {
      unit.getUnits().then((message) {
        if (message != "success") {
          customSnackbar(message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.selectedUnit != null) {
        pickedOption = unit.units
            .firstWhere((val) => val.id == widget.selectedUnit)
            .model;
      }
      return CustomDropDown(
        onChanged: (val) {
          final selectedUnit = unit.units.elementAt(val);
          if (widget.onChanged != null) widget.onChanged!(selectedUnit);
        },
        addNewCallback: () {
          Get.to(() => AddUnit());
        },
        pickedOption: pickedOption,
        isLoading: unit.isLoading.value,
        options: unit.units.map((val) => val.model).toList(),
        hintText: widget.hintText,
        title: "Select Unit",
      );
    });
  }
}
