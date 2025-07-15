import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Dropdown.dart';
import 'package:posilkiapp/ViewModel/MealsViewModel.dart';
import 'package:provider/provider.dart';

class Rowview extends StatelessWidget {
  final VoidCallback? leftButtonPressed;
  final VoidCallback? rightButtonPressed;
  final VoidCallback? mainButtonPressed;
  final String bottomText;

  const Rowview({
    Key? key,
    this.leftButtonPressed,
    this.rightButtonPressed,
    this.mainButtonPressed,
    this.bottomText = "Logo",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MealsViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isChecked = false;
    TextEditingController priceController = TextEditingController();
    return SizedBox(
      child: Row(
        children: [
          // Górny pasek z dwoma przyciskami
          Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text("Grupa"),
                      // SizedBox(height: 14),
                      // Text("VAT"),
                    ],
                  ),
                  SizedBox(width: 12),
                  Column(
                    children: [
                      Container(
                        width: screenWidth / 10,
                        child: CustomDropdownMenu(
                          list: vm.groupSelect,
                          onSelected: (selectedGroup) {
                            print(
                              "Wybrano grupę: ${selectedGroup.name}, ID: ${selectedGroup.Id}",
                            );
                            // Zapisz do zmiennej w ViewModelu albo użyj bezpośrednio
                            vm.selectedGroupId = selectedGroup.Id;
                          },
                        ),
                      ),
                      // Container(
                      //   width: screenWidth / 10,
                      //   child: CustomDropdownMenu(
                      //     list: ['Opcja 1', 'Opcja 2', 'Opcja 3'],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         Checkbox(
          //           checkColor: Colors.white,

          //           value: isChecked,
          //           onChanged: (bool? value) {
          //             isChecked = value!;
          //           },
          //         ),
          //         Text("Zmiana 1"),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Checkbox(
          //           checkColor: Colors.white,

          //           value: isChecked,
          //           onChanged: (bool? value) {
          //             isChecked = value!;
          //           },
          //         ),
          //         Text("Zmiana 2"),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Checkbox(
          //           checkColor: Colors.white,

          //           value: isChecked,
          //           onChanged: (bool? value) {
          //             isChecked = value!;
          //           },
          //         ),
          //         Text("Zmiana 3"),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
