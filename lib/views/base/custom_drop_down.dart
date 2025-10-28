import 'package:template/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/app_texts.dart';
import 'package:template/utils/custom_svg.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final int? initialPick;
  final String? hintText;
  final List<String> options;
  final double height;
  final double? width;
  final double radius;
  final void Function(String)? onChanged;
  const CustomDropDown({
    super.key,
    this.title,
    this.initialPick,
    this.hintText,
    required this.options,
    this.onChanged,
    this.radius = 8,
    this.height = 46,
    this.width,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // === Configurable UI Constants ===
  final double horizontalPadding = 14;
  final double verticalSpacing = 4;
  final double iconSize = 24;
  final double borderWidth = 0.5;

  final Color backgroundColor = AppColors.gray[50]!;
  final Color borderColorExpanded = AppColors.gray.shade900;
  final Color borderColorCollapsed = AppColors.gray.shade100;
  final Color hintTextColor = AppColors.gray.shade300;
  final Color textColor = AppColors.gray.shade900;
  final Color dividerColor = AppColors.gray;

  final Duration animationDuration = const Duration(milliseconds: 100);

  String? currentVal;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialPick != null) {
      currentVal = widget.options[widget.initialPick!];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(bottom: verticalSpacing),
            child: Text(
              widget.title!,
              style: AppTexts.txsm.copyWith(color: hintTextColor),
            ),
          ),

        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            constraints: BoxConstraints(minHeight: widget.height),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(widget.radius),
              border: Border.all(
                color: isExpanded ? borderColorExpanded : borderColorCollapsed,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: widget.height,
                  child: Row(
                    children: [
                      SizedBox(width: horizontalPadding),
                      currentVal == null || isExpanded
                          ? Text(
                              widget.hintText ?? "Select One",
                              style: AppTexts.tsmr.copyWith(
                                color: hintTextColor,
                              ),
                            )
                          : Text(
                              currentVal!,
                              style: AppTexts.tsmr.copyWith(
                                color: textColor,
                              ),
                            ),
                      const Spacer(),
                      AnimatedRotation(
                        duration: animationDuration,
                        turns: isExpanded ? 0.5 : 1,
                        child: CustomSvg(
                          asset: "assets/icons/drop_down.svg",
                          color: textColor,
                          size: iconSize,
                        ),
                      ),
                      SizedBox(width: horizontalPadding),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: animationDuration,
                  child: isExpanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...widget.options.map((e) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = false;
                                    currentVal = e;
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(e);
                                    }
                                  });
                                },
                                child: Container(
                                  height: widget.height,
                                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: dividerColor,
                                        width: borderWidth,
                                      ),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(e, style: AppTexts.tsmr),
                                  ),
                                ),
                              );
                            }),
                          ],
                        )
                      : SizedBox(height: 0, width: double.infinity),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
