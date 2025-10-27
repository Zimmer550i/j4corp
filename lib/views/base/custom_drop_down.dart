import 'package:template/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/app_texts.dart';
import 'package:template/utils/custom_svg.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final int? initialPick;
  final String? hintText;
  final List<String> options;
  final double? height;
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
  String? currentVal;
  bool isExpanded = false;
  Duration defaultDuration = const Duration(milliseconds: 100);

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
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              widget.title!,
              style: AppTexts.txsm.copyWith(color: AppColors.gray.shade500),
            ),
          ),

        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            constraints: BoxConstraints(minHeight: widget.height!),
            decoration: BoxDecoration(
              color: AppColors.gray[50],
              borderRadius: BorderRadius.circular(widget.radius),
              border: Border.all(
                color: isExpanded
                    ? AppColors.gray.shade900
                    : AppColors.gray.shade100,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: widget.height ?? 50,
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      currentVal == null || isExpanded
                          ? Text(
                              widget.hintText ?? "Select One",
                              style: AppTexts.tsmr.copyWith(
                                color: AppColors.gray.shade300,
                              ),
                            )
                          : Text(
                              currentVal!,
                              style: AppTexts.tsmr.copyWith(
                                color: AppColors.gray.shade900,
                              ),
                            ),
                      const Spacer(),
                      AnimatedRotation(
                        duration: defaultDuration,
                        turns: isExpanded ? 0.5 : 1,
                        child: CustomSvg(
                          asset: "assets/icons/drop_down.svg",
                          color: AppColors.gray.shade900,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: defaultDuration,
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
                                  height: widget.height ?? 50,
                                  padding: EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.gray,
                                        width: 0.5,
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
