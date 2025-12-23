import 'package:j4corp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:j4corp/utils/app_texts.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/base/custom_loading.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final String? pickedOption;
  final String? hintText;
  final List<String> options;
  final List<String>? address;
  final double height;
  final double? width;
  final double radius;
  final bool isLoading;
  final void Function(int)? onChanged;
  final void Function()? addNewCallback;
  const CustomDropDown({
    super.key,
    this.title,
    this.pickedOption,
    this.hintText,
    required this.options,
    this.address,
    this.onChanged,
    this.addNewCallback,
    this.radius = 8,
    this.height = 46,
    this.isLoading = false,
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

  final Color backgroundColor = AppColors.gray[25]!;
  final Color borderColorExpanded = AppColors.gray.shade900;
  final Color borderColorCollapsed = AppColors.gray.shade100;
  final Color hintTextColor = AppColors.gray.shade300;
  final Color textColor = AppColors.gray.shade900;
  final Color dividerColor = AppColors.gray;
  final scroll = ScrollController();

  final Duration animationDuration = const Duration(milliseconds: 100);

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
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
              style: AppTexts.txsm.copyWith(color: dividerColor),
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
                      widget.pickedOption != null
                          ? Text(
                              widget.pickedOption!,
                              style: AppTexts.tsmr.copyWith(color: textColor),
                            )
                          : Text(
                              widget.hintText ?? "Select One",
                              style: AppTexts.tsmr.copyWith(
                                color: hintTextColor,
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
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: widget.height * 4.5,
                          ),
                          child: Scrollbar(
                            controller: scroll,
                            trackVisibility: true,
                            thumbVisibility: true,
                            interactive: true,
                            child: SingleChildScrollView(
                              controller: scroll,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.isLoading)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomLoading(),
                                    ),
                                  for (int i = 0; i < getItemCount(); i++)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isExpanded = false;
                                          if (i < widget.options.length) {
                                            if (widget.onChanged != null) {
                                              widget.onChanged!(i);
                                            }
                                          } else {
                                            widget.addNewCallback!();
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: horizontalPadding,
                                          vertical: horizontalPadding,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: dividerColor,
                                              width: borderWidth,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              spacing: 10,
                                              children: [
                                                if (widget.options.length == i)
                                                  CustomSvg(
                                                    asset:
                                                        "assets/icons/plus.svg",
                                                    color:
                                                        AppColors.gray.shade900,
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    widget.options.length == i
                                                        ? "Add New"
                                                        : widget.options
                                                              .elementAt(i),
                                                    style: AppTexts.tsmr,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (widget.address != null)
                                              Row(
                                                spacing: 4,
                                                children: [
                                                  CustomSvg(
                                                    asset:
                                                        "assets/icons/pin.svg",
                                                  ),
                                                  Text(
                                                    widget.address!.elementAt(
                                                      i,
                                                    ),
                                                    style: AppTexts.txsr
                                                        .copyWith(
                                                          color: AppColors
                                                              .gray
                                                              .shade600,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
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

  int getItemCount() {
    return widget.addNewCallback != null
        ? widget.options.length + 1
        : widget.options.length;
  }
}
