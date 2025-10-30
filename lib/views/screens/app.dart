import 'package:flutter/material.dart';
import 'package:j4corp/views/base/custom_bottom_navbar.dart';
import 'package:j4corp/views/screens/chat.dart';
import 'package:j4corp/views/screens/home/home.dart';
import 'package:j4corp/views/screens/sell.dart';
import 'package:j4corp/views/screens/services.dart';
import 'package:j4corp/views/screens/settings/settings.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  List<Widget> pages = [
    Home(),
    Services(),
    Sell(),
    Chat(),
    Settings(),
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
