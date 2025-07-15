import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/ViewModel/MealsViewModel.dart';
import 'package:provider/provider.dart';

class Groupview extends StatelessWidget {
  const Groupview({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MealsViewModel>(context);

    List<String> listText = ["PL", "EN", "DE"];
    List<TextEditingController> controllers = List.generate(
      3,
      (_) => TextEditingController(),
    );

    // final vm = Provider.of<MealsViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final squareButton = Squarebutton();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Stack(
                children: [
                  Center(child: Text("Grupa", style: TextStyle(fontSize: 30))),

                  Positioned(
                    right: 25,
                    top: 0,
                    bottom: 0,
                    child: squareButton.buildSquareButtonText(
                      "Zapisz",
                      screenHeight,
                      screenWidth,
                      screenHeight / 50,
                      context,
                      () {
                        vm.createFromGroups(controllers);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(3, (index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // lub .center
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tekst z opisem
                    SizedBox(
                      width: screenWidth / 20,
                      child: Text(
                        listText[index],
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),

                    // TextField 1
                    SizedBox(
                      width: screenWidth / 3,
                      height: 40,
                      child: TextField(
                        controller: controllers[index],
                        style: TextStyle(fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    // TextField 2
                    // SizedBox(
                    //   width: screenWidth / 10,
                    //   height: 30,
                    //   child: TextField(
                    //     controller: controllers2[index],
                    //     keyboardType: const TextInputType.numberWithOptions(
                    //       decimal: true,
                    //     ),
                    //     decoration: const InputDecoration(
                    //       labelText: 'Nowa cena',
                    //       border: OutlineInputBorder(),
                    //     ),
                    //   ),
                    // ),

                    // Gramatura
                    // SizedBox(
                    //   width: screenWidth / 20,
                    //   child: Text( gram[index]),
                    // ),
                  ],
                );
              }),
            ),
            // SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     vm.createFromGroups(controllers);
            //   },
            //   child: Text("Zapisz"),
            // ),
          ],
        ),
      ),
    );
  }
}
