import 'package:flutter/material.dart';
import 'package:template/views/base/custom_app_bar.dart';
import 'package:template/views/base/custom_button.dart';
import 'package:template/views/base/custom_text_field.dart';
import 'package:template/views/base/profile_picture.dart';

class DesignSystem extends StatelessWidget {
  const DesignSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Design System"),
      body: Column(
        spacing: 16,
        children: [
        ProfilePicture(image: "https://picsum.photos/500/500", isEditable: true,),
        CustomTextField(),
        CustomTextField(isPassword: true,),
        CustomButton(text: "Button"),

      ],),
    );
  }
}