import 'package:flutter/material.dart';
import 'package:posilkiapp/Model/MealsModel.dart';
import 'package:posilkiapp/View/Meal/AllergenView.dart';
import 'package:posilkiapp/View/Meal/GroupView.dart';
import 'package:posilkiapp/View/Meal/MealsView.dart';

class Addingview extends StatelessWidget {
  const Addingview({super.key});

  @override
  Widget build(BuildContext context) {
    // final vm = Provider.of<MealsViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final model = MealsModel();

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            SizedBox(
              width: (screenWidth - model.thickness) * 3 / 4,
              child: MealsView(),
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: model.thickness,
              width: 1,
            ),
            Column(
              children: [
                SizedBox(
                  width: (screenWidth - model.thickness) / 4,
                  height: (screenHeight - model.thickness) / 2,
                  child: Allergenview(),
                ),
                Container(
                  width: (screenWidth - model.thickness) / 4,
                  height: model.thickness,
                  color: Colors.black,
                ),

                SizedBox(
                  width: (screenWidth - model.thickness) / 4,
                  height: (screenHeight - model.thickness) / 2,
                  child: Groupview(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
