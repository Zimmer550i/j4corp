import 'package:flutter/material.dart';
import 'package:j4corp/views/base/custom_bottom_navbar.dart';
import 'package:j4corp/views/screens/sell.dart';
import 'package:j4corp/views/screens/services.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  List<Widget> pages = [
    FlutterLogo(),
    Services(),
    Sell(),
    FlutterLogo(),
    FlutterLogo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: CustomBottomNavbar(
        index: index,
        onChanged: (val) {
          setState(() {
            index = val;
          });
        },
      ),
    );
  }
}
