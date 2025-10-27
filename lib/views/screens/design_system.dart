import 'package:flutter/material.dart';
import 'package:template/views/base/custom_app_bar.dart';
import 'package:template/views/base/custom_bottom_navbar.dart';
import 'package:template/views/base/custom_button.dart';
import 'package:template/views/base/custom_drop_down.dart';
import 'package:template/views/base/custom_text_field.dart';
import 'package:template/views/base/profile_picture.dart';

class DesignSystem extends StatefulWidget {
  const DesignSystem({super.key});

  @override
  State<DesignSystem> createState() => _DesignSystemState();
}

class _DesignSystemState extends State<DesignSystem> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Design System"),
      bottomNavigationBar: CustomBottomNavbar(
        index: index,
        onChanged: (val) {
          setState(() {
            index = val;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 16,
          children: [
            ProfilePicture(
              image: "https://picsum.photos/500/500",
              isEditable: true,
            ),
            CustomTextField(
              title: "Email",
              hintText: "Enter your email",
              leading: "assets/icons/eye.svg",
            ),
            CustomTextField(isPassword: true),
            CustomDropDown(
              title: "Sample Dropdown",
              options: ["Options 1", "Options 2"]),
            CustomButton(text: "Button"),
            CustomButton(text: "Secondary Button", isSecondary: true),
          ],
        ),
      ),
    );
  }
}
