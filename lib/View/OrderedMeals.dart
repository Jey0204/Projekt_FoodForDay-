import 'package:flutter/material.dart';
import 'package:posilkiapp/Model/ApiClasses.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/ViewModel/OrderedMealViewModel.dart';
import 'package:posilkiapp/ViewModel/OrderedMealsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Orderedmeals extends StatefulWidget {
  const Orderedmeals({super.key});

  @override
  State<Orderedmeals> createState() => _OrderedmealsState();
}

class _OrderedmealsState extends State<Orderedmeals> {
  late Orderedmealviewmodel vm;

  @override
  void initState() {
    super.initState();

    // Delay, aby mieć dostęp do kontekstu po buildzie
    Future.microtask(() {
      vm = Provider.of<Orderedmealviewmodel>(context, listen: false);
      vm.fetchOrder(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ); // lub DateTime.now() sformatowane
    });
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<Orderedmealviewmodel>(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final squareButton = Squarebutton();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Center(child: Text("Zamówienia", style: TextStyle(fontSize: 30))),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [Text("Zmiana 1"), SizedBox(width: 30)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              squareButton.buildTransparentArrowButton(
                screenWidth,
                screenHeight,
                context,
                () => vm.goToPreviousDay(),
                Icons.arrow_back,
              ),
              const Spacer(),
              Text(vm.formattedDate),
              const Spacer(),
              squareButton.buildTransparentArrowButton(
                screenWidth,
                screenHeight,
                context,
                () => vm.goToNextDay(),
                Icons.arrow_forward,
              ),
              const SizedBox(width: 30),
            ],
          ),
          SizedBox(
            width: screenWidth * 7 / 16,
            height: screenHeight / 2,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Colors.white),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Nazwa posiłku',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Zmiana',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Zamówione',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                ...vm.mealsStatusDay.map(
                  (meal) => TableRow(
                    decoration: const BoxDecoration(color: Colors.white),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          meal.name ?? '',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          meal.shiftId?.toString() ?? '',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          meal.number?.toString() ?? '',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
