import 'package:flutter/material.dart';
import 'package:posilkiapp/View/AddMenu.dart';
import 'package:posilkiapp/View/AddShift.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/View/Meal/AddingView.dart';
import 'package:posilkiapp/View/Meal/AllergenView.dart';
import 'package:posilkiapp/View/Meal/GroupView.dart';
import 'package:posilkiapp/View/Meal/MealsView.dart';
import 'package:posilkiapp/View/OrderedMeals.dart';
import 'package:posilkiapp/View/Statistics.dart';
import 'package:posilkiapp/ViewModel/MainViewViewModel.dart';
import 'package:provider/provider.dart';

class Centerview extends StatelessWidget {
  const Centerview({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Mainviewviewmodel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final squareButton = Squarebutton();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/tlo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: vm.isAddMenuSelected,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Addmenu(),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: vm.isAllergen,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Allergenview(),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: vm.isGroup,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Groupview(),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: vm.isMeal,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: MealsView(),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: vm.isAddShiftSelected,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Addshift(),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: vm.isRaport,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Statistics(),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: vm.isKonfig,
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight * 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Orderedmeals(),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: vm.isEditSelected || vm.isPlan,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      vm.isEditSelected ? "Posiłki" : "Jadłospis",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        squareButton.buildSquareButton(
                          vm.isPlan ? Icons.menu_book : Icons.add,
                          vm.isPlan ? "Dodaj jadłospis" : "Dodaj Posiłek",
                          screenHeight,
                          context,
                          vm.isPlan
                              ? () {
                                vm.toggleAddMenu();
                              }
                              : () {
                                vm.toggleMeal();
                              },
                        ),
                        squareButton.buildSquareButton(
                          vm.isPlan ? Icons.schedule : Icons.warning,
                          vm.isPlan ? "Dodaj zmianę" : "Dodaj Alergeny",
                          screenHeight,
                          context,
                          () {
                            vm.isPlan
                                ? vm.toggleAddShift()
                                : vm.toggleAllergen();
                          },
                        ),
                        Visibility(
                          visible: vm.isEditSelected,
                          child: squareButton.buildSquareButton(
                            Icons.category,
                            "Dodaj Grupy",
                            screenHeight,
                            context,
                            () {
                              vm.toggleGroup();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
