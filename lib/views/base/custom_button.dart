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
  // === Configurable UI Constants ===
  final Duration animationDuration = const Duration(milliseconds: 100);
  final double loaderPadding = 8.0;
  final double loaderStrokeWidth = 4.0;

  final Color primaryColor = AppColors.gray.shade900;
  final Color secondaryColor = AppColors.gray[50]!;
  final Color disabledColor = AppColors.gray.shade300;
  final Color borderColor = AppColors.gray.shade900;
  final Color primaryTextColor = AppColors.white;
  final Color secondaryTextColor = AppColors.gray.shade900;
  final Color loaderColorPrimary = AppColors.gray[50]!;
  final Color loaderColorSecondary = AppColors.gray;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: animationDuration,
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        decoration: BoxDecoration(
          color: widget.isSecondary
              ? secondaryColor
              : widget.isDisabled
                  ? disabledColor
                  : primaryColor,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: borderColor),
        ),
        child: widget.isLoading
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.all(loaderPadding),
                  child: CircularProgressIndicator(
                    color: widget.isSecondary
                        ? loaderColorSecondary
                        : loaderColorPrimary,
                    strokeWidth: loaderStrokeWidth,
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
                            ? secondaryTextColor
                            : primaryTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  Text(
                    widget.text,
                    style: AppTexts.tsmm.copyWith(
                      fontSize: widget.fontSize,
                      color: widget.isSecondary
                          ? secondaryTextColor
                          : primaryTextColor,
                    ),
                  ),
                  if (widget.trailing != null)
                    SvgPicture.asset(
                      widget.trailing!,
                      height: widget.iconSize,
                      width: widget.iconSize,
                      colorFilter: ColorFilter.mode(
                        widget.isSecondary
                            ? secondaryTextColor
                            : primaryTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
