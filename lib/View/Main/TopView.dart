import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/View/Meal/AddingView.dart';
import 'package:posilkiapp/View/OrderedMeals.dart';
import 'package:posilkiapp/ViewModel/MainViewViewModel.dart';
import 'package:provider/provider.dart';

class Topview extends StatelessWidget {
  const Topview({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Mainviewviewmodel>(context);
    final squareButton = Squarebutton();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double screen = 0; /////dopracowac
    if (screenHeight * 3 / 16 > screenWidth / 18) {
      screen = screenHeight;
    } else {
      screen = screenWidth;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10),
            SizedBox(
                width: screenHeight * 3 / 16,
                height: screenHeight * 3 / 16,
                child:
                    // Image.asset('assets/logo.jpg', fit: BoxFit.contain),
                    Text("Logo")),
            Spacer(),
            squareButton.buildSquareButton(
              Icons.restaurant,
              "Jadłospis",
              screen,
              context,
              () {
                vm.allFalse();
                vm.togglePlan();
              },
            ),
            //table_chart_outlined
            squareButton.buildSquareButton(
              Icons.fastfood,
              "Posiłki",
              screen,
              context,
              () {
                vm.allFalse();
                vm.toggleEdit();
              },
            ),

            squareButton.buildSquareButton(
              Icons.note_alt,
              "Zamówienia",
              screen,
              context,
              () {
                vm.allFalse();
                vm.toggleKonfig();
              },
            ),
            squareButton.buildSquareButton(
              Icons.bar_chart_rounded,
              "Statystyka",
              screen,
              context,
              () {
                vm.allFalse();
                vm.toggleRaport();
              },
            ),
            SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
