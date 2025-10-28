import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/screens/auth/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 2));
      Get.off(() => Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D0D1B),
      body: Stack(
        children: [
          Positioned(
            right: -80,
            top: -80,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: CustomSvg(asset: "assets/icons/shade.svg"),
            ),
          ),
          Positioned.fill(
            child: Center(child: Image.asset("assets/images/logo.png")),
          ),
        ],
      ),
    );
  }
}
