import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:j4corp/controllers/auth_controller.dart';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/utils/custom_svg.dart';
import 'package:j4corp/views/screens/app.dart';
import 'package:j4corp/views/screens/auth/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isVerified = false;
  Duration animationDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    verifyToken();
  }

  void verifyToken() async {
    final time = Stopwatch();
    time.start();
    isVerified = await Get.find<AuthController>().previouslyLoggedIn();
    if (isVerified) await Get.find<UserController>().getUserData();

    if (time.elapsed < animationDuration) {
      await Future.delayed(animationDuration - time.elapsed);
    }

    if (isVerified) {
      Get.offAll(() => App(), routeName: "/app");
    } else {
      Get.offAll(() => Login());
    }
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
