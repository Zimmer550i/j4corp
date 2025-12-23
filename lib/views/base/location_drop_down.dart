import 'package:flutter/material.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';

class LocationDropDown extends StatefulWidget {
  final void Function(String value) onChanged;
  final String? initial;
  final String? hintText;
  const LocationDropDown({
    super.key,
    required this.onChanged,
    this.initial,
    this.hintText,
  });

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  String? pickedOption;
  final options = [
    "BMW Motorcycles of San Antonio",
    "BMG Xtreme Sports",
    "Triumph Houston",
  ];
  final address = ["San Antonio", "Lav Segas", "Houston"];

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) pickedOption = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropDown(
      title: "Store Location",
      pickedOption: pickedOption,
      hintText: widget.hintText,
      options: options,
      address: address,
      onChanged: (pos) {
        setState(() {
          pickedOption = options[pos];
        });
        widget.onChanged(options[pos]);
      },
    );
  }
}
