import 'package:flutter/material.dart';
import 'package:template/utils/app_colors.dart';
import 'package:template/utils/custom_svg.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function(int) onChanged;
  const CustomBottomNavbar({
    super.key,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: AppColors.gray.shade900),
      child: BottomNavigationBar(
        backgroundColor: AppColors.gray.shade900,
        currentIndex: index,
        onTap: onChanged,
        items: [
          BottomNavigationBarItem(
            icon: CustomSvg(asset: "assets/icons/home.svg"),
            activeIcon: CustomSvg(asset: "assets/icons/home_active.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CustomSvg(asset: "assets/icons/services.svg"),
            activeIcon: CustomSvg(asset: "assets/icons/services_active.svg"),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: CustomSvg(asset: "assets/icons/sell.svg"),
            activeIcon: CustomSvg(asset: "assets/icons/sell_active.svg"),
            label: "Sell",
          ),
          BottomNavigationBarItem(
            icon: CustomSvg(asset: "assets/icons/mail.svg"),
            activeIcon: CustomSvg(asset: "assets/icons/mail_active.svg"),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: CustomSvg(asset: "assets/icons/settings.svg"),
            activeIcon: CustomSvg(asset: "assets/icons/settings_active.svg"),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
