import 'package:template/utils/app_colors.dart';
import 'package:template/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/utils/app_texts.dart';

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
    this.radius = 24,
    this.height,
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
      spacing: 8,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: TextStyle(
              fontVariations: [FontVariation("wght", 600)],
              fontSize: 16,
              color: AppColors.blue[600],
            ),
          ),

        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.black[400],
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: widget.height,
                  child: Row(
                    children: [
                      currentVal == null
                          ? Text(
                              widget.hintText ?? "Select One",
                              style: AppTexts.tsmr.copyWith(
                                color: AppColors.black.shade200,
                              ),
                            )
                          : Text(
                              currentVal!,
                              style: AppTexts.tsmr.copyWith(
                                color: AppColors.black.shade50,
                              ),
                            ),
                      const Spacer(),
                      AnimatedRotation(
                        duration: defaultDuration,
                        turns: isExpanded ? 0.5 : 1,
                        child: SvgPicture.asset(AppIcons.arrowDown),
                      ),
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
                                  height: widget.height,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.blue[400]!,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        color: AppColors.blue[50],
                                        fontSize: 14,
                                      ),
                                    ),
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
