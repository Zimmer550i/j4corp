import 'package:template/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/utils/app_texts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool isSecondary;
  final bool isDisabled;
  final double? height;
  final double? width;
  final bool isLoading;
  final String? leading;
  final String? trailing;
  final double padding;
  final double radius;
  final double fontSize;
  final double iconSize;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.trailing,
    this.padding = 40,
    this.radius = 8,
    this.isSecondary = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.fontSize = 14,
    this.iconSize = 24,
    this.height = 48,
    this.width = double.infinity,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        decoration: BoxDecoration(
          color: widget.isSecondary
              ? AppColors.gray[50]
              : widget.isDisabled
              ? AppColors.gray.shade300
              : AppColors.gray.shade900,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: AppColors.gray.shade900),
        ),
        child: widget.isLoading
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: widget.isSecondary
                        ? AppColors.gray
                        : AppColors.gray[50],
                    strokeWidth: 4,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  if (widget.leading != null)
                    SvgPicture.asset(
                      widget.leading!,
                      height: widget.iconSize,
                      width: widget.iconSize,
                      colorFilter: ColorFilter.mode(
                        widget.isSecondary
                            ? AppColors.gray.shade900
                            : AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  Text(
                    widget.text,
                    style: AppTexts.tsmm.copyWith(
                      fontSize: widget.fontSize,
                      color: widget.isSecondary
                          ? AppColors.gray.shade900
                          : AppColors.white,
                    ),
                  ),
                  if (widget.trailing != null)
                    SvgPicture.asset(
                      widget.trailing!,
                      height: widget.iconSize,
                      width: widget.iconSize,
                      colorFilter: ColorFilter.mode(
                        widget.isSecondary
                            ? AppColors.gray.shade900
                            : AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
