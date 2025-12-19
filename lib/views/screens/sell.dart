import 'package:flutter/material.dart';
import 'package:j4corp/views/base/custom_app_bar.dart';
import 'package:j4corp/views/base/custom_button.dart';
import 'package:j4corp/views/base/custom_drop_down.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sell Us Your Bike", hasLeading: false),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(),
                CustomDropDown(
                  onChanged: (val) {
                    setState(() {
                      selected = val;
                    });
                  },
                  options: [
                    "Kawasaki-KLX110R",
                    "Kawasaki-KLX110R",
                    "Kawasaki-KLX110R",
                  ],
                  title: "Select Unit",
                ),
                
                // if (selected != null) VehicleCard(),
                if (selected != null) CustomButton(text: "Submit"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
