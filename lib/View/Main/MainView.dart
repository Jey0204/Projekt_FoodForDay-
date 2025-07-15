import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Main/BottomView.dart';
import 'package:posilkiapp/View/Main/CenterView.dart';
import 'package:posilkiapp/View/Main/TopView.dart';

class Mainview extends StatelessWidget {
  const Mainview({super.key});

  @override
  Widget build(BuildContext context) {
    // final vm = Provider.of<MealsViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: screenHeight * 3 / 16,
                  width: screenWidth,
                  child: Topview(),
                ),

                // ŚRODKOWY RZĄD
                Container(
                  height: screenHeight * 12 / 16,
                  width: screenWidth,
                  child: Centerview(),
                ),

                // DOLNY RZĄD
                Container(
                  height: screenHeight * 1 / 16,
                  width: screenWidth,
                  alignment: Alignment.center,
                  child: Bottomview(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
