import 'package:flutter/material.dart';
import 'package:posilkiapp/Model/ApiClasses.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/ViewModel/AddShiftViewModel.dart';
import 'package:provider/provider.dart';

class Addshift extends StatelessWidget {
  const Addshift({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Addshiftviewmodel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchCanteenInfo();
    });
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final squareButton = Squarebutton();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Stack(
                children: [
                  Center(
                    child: Text("Dodaj zmianę", style: TextStyle(fontSize: 30)),
                  ),

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
                        print(vm.shift[0].check);
                        print(vm.shift[0].canteen);
                        print(vm.shift[0].canteenName);
                        print(vm.shift[0].name);
                        print(vm.shift[0].timeEnd);
                        print(vm.shift[0].timeStart);
                        print(vm.shift[0].id);
                        print(vm.shift[1].check);
                        print(vm.shift[1].canteen);
                        print(vm.shift[1].canteenName);
                        print(vm.shift[1].name);
                        print(vm.shift[1].timeEnd);
                        print(vm.shift[1].timeStart);
                        print(vm.shift[1].id);

                        print(vm.name.text);

                        vm.saveAll();
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Column(
                  children: [
                    Text("Nazwa"),
                    Container(
                      width: screenWidth / 6,
                      height: 40,

                      child: TextField(
                        controller: vm.name,
                        style: TextStyle(fontSize: 16),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: (screenWidth - 30) / 3,
                  height: screenHeight / 2,
                  child: ListView.builder(
                    itemCount: vm.canteen.length,
                    itemBuilder: (context, index) {
                      return _buildStolowkaRow(
                        context,
                        screenWidth,
                        vm.shift[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStolowkaRow(
    BuildContext context,
    double screenWidth,
    Shift shiftData,
  ) {
    final fromController = TextEditingController(text: shiftData.timeStart);
    final toController = TextEditingController(text: shiftData.timeEnd);
    final vm = Provider.of<Addshiftviewmodel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 8,
            child: Row(
              children: [
                Checkbox(
                  value: shiftData.check,
                  onChanged: (val) {
                    shiftData.check = val ?? false;
                    Provider.of<Addshiftviewmodel>(
                      context,
                      listen: false,
                    ).notifyListeners();
                  },
                ),
                Flexible(child: Text(shiftData.canteenName ?? '')),
              ],
            ),
          ),
          SizedBox(
            width: screenWidth / 13,
            height: 40,
            child: TextField(
              controller: fromController,
              onChanged: (val) {
                String timeFormatted = vm.convertToTimeFormat(val);
                shiftData.timeStart = timeFormatted;
                // shiftData.timeStart = val;
              },
              decoration: InputDecoration(
                hintText: 'Od',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: screenWidth / 13,
            height: 40,
            child: TextField(
              controller: toController,
              onChanged: (val) {
                String timeFormatted = vm.convertToTimeFormat(val);
                shiftData.timeEnd = timeFormatted;
                // shiftData.timeEnd = val;
              },
              decoration: InputDecoration(
                hintText: 'Do',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
