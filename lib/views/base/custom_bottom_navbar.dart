import 'package:flutter/material.dart';
import 'package:template/utils/app_colors.dart';
import 'package:template/utils/app_icons.dart';
import 'package:template/utils/app_texts.dart';
import 'package:template/utils/custom_svg.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function(int)? onChanged;
  const CustomBottomNavbar({super.key, required this.index, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff333333))),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 16,
            color: Colors.black.withAlpha(27),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            item("Home", AppIcons.home, 0),
            item("Pool", AppIcons.pool, 1),
            item("Settings", AppIcons.settings, 2),
          ],
        ),
      ),
    );
  }

  Widget item(String name, String icon, int pos) {
    bool isSelected = pos == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) onChanged!(pos);
        },
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            CustomSvg(
              asset: icon,
              size: 24,
              color: isSelected ? AppColors.blue : AppColors.black.shade100,
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: AppTexts.tsmm.copyWith(
                color: isSelected ? AppColors.blue : AppColors.black.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
