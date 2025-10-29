import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:j4corp/utils/app_colors.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';

class CustomDatePicker extends StatefulWidget {
  final String? title;
  final DateTime? date;
  final void Function(DateTime) callBack;
  const CustomDatePicker({
    super.key,
    this.title,
    this.date,
    required this.callBack,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              widget.title!,
              style: AppTexts.txsm.copyWith(color: AppColors.gray.shade500),
            ),
          ),

        GestureDetector(
          onTap: () async {
            final temp = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
            );

            if (temp != null) {
              widget.callBack(temp);
            }
          },
          child: Container(
            height: 46,
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.gray[25],
              border: Border.all(color: AppColors.gray.shade100),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Color(0x3dE4E5E7),
                ),
              ],
            ),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Text(
                    widget.date != null
                        ? DateFormat("dd MMMM, yyyy").format(widget.date!)
                        : "Pick a date",
                    style: AppTexts.tsmr.copyWith(
                      color: widget.date != null
                          ? AppColors.gray.shade900
                          : AppColors.gray.shade300,
                    ),
                  ),
                ),
                CustomSvg(
                  asset: "assets/icons/services.svg",
                  color: AppColors.gray.shade900,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
