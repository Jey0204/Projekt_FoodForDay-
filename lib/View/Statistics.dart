import 'package:flutter/material.dart';
import 'package:posilkiapp/View/BarchSample.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/ViewModel/StatisticsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Statisticsviewmodel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final squareButton = Squarebutton();

    return Container(
      color: Colors.white,

      child: Column(
        children: [
          Center(child: Text("Statystyka", style: TextStyle(fontSize: 30))),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30),
              squareButton.buildSquareButtonText(
                "Dzień",
                screenHeight / 4,
                screenWidth,
                screenHeight / 50,
                context,
                () {
                  vm.isDMY(0);
                  // vm.dataChange();
                },
              ),
              squareButton.buildSquareButtonText(
                "Miesiąc",
                screenHeight / 4,
                screenWidth,
                screenHeight / 50,
                context,
                () {
                  vm.isDMY(1);
                  // vm.getDataMonth();
                },
              ),
              squareButton.buildSquareButtonText(
                "Rok",
                screenHeight / 4,
                screenWidth,
                screenHeight / 50,
                context,
                () {
                  vm.isDMY(2);
                  vm.getSelectedYear("da935c0b-580d-45ae-449d-08d94195ff01");
                  print(vm.formattedYear);
                  print(vm.formattedMonth);
                  // vm.getDataYear();
                },
              ),
            ],
          ),
          // Visibility(
          //   visible: vm.isData,
          //   child: SizedBox(
          //     width: screenWidth * 7 / 16,
          //     height: screenHeight * 9 / 16,

          //     child: StatefulBuilder(
          //       builder: (BuildContext context, StateSetter setState) {
          //         return TableCalendar(
          //           startingDayOfWeek: StartingDayOfWeek.monday,
          //           firstDay: DateTime.utc(2020, 1, 1),
          //           lastDay: DateTime.utc(2030, 12, 31),
          //           focusedDay: vm.focusedDay,
          //           calendarStyle: CalendarStyle(
          //             selectedDecoration: BoxDecoration(
          //               color: const Color.fromARGB(255, 79, 135, 0),
          //               shape: BoxShape.circle,
          //             ),
          //           ),
          //           selectedDayPredicate: (day) {
          //             return isSameDay(vm.selectedDay, day);
          //           },
          //           calendarFormat: CalendarFormat.month,
          //           headerStyle: HeaderStyle(
          //             titleCentered: true,
          //             formatButtonVisible: false,
          //           ),
          //           onDaySelected: (newSelectedDay, newFocusedDay) {
          //             setState(() {
          //               vm.selectedDay = newSelectedDay;
          //               vm.focusedDay = newFocusedDay;
          //             });

          //             vm.formattedDate = DateFormat(
          //               'yyyy-MM-dd',
          //             ).format(vm.selectedDay!);
          //             vm.dataChange();
          //             vm.getSelectedData(vm.formattedDate);
          //             print(vm.formattedDate);
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
          Visibility(
            visible: !vm.isData,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 30),
                    squareButton.buildTransparentArrowButton(
                      screenWidth,
                      screenHeight,
                      context,
                      () => print('Kliknięto arrow'),
                      Icons.arrow_back,
                    ),
                    Spacer(),
                    Text(vm.formattedDate),
                    Spacer(),
                    squareButton.buildTransparentArrowButton(
                      screenWidth,
                      screenHeight,
                      context,
                      () => print('Kliknięto arrow'),
                      Icons.arrow_forward,
                    ),
                    SizedBox(width: 30),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 1 / 4,
                  width: screenWidth * 8 / 16,

                  child:
                      vm.isDayMonthYear == 0
                          ? BarChartSample(
                            quantityData: [1, 2, 3, 4],
                            costData: [44, 22, 2, 5],
                            profitData: [34, 28, 1, 5],
                            labels: ["1", '2', '2', '3'],
                            // tylko 2 pierwsze dni
                          )
                          : vm.isDayMonthYear == 1
                          ? BarChartSample(
                            quantityData: [1, 2, 3, 4],
                            costData: [54, 45, 2, 5],
                            profitData: [34, 28, 1, 5],
                            labels: ["1", '2', '2', '3'],
                            // tylko 2 pierwsze dni
                          )
                          : BarChartSample(
                            quantityData: vm.totalMealsSoldList,
                            costData: [54, 45, 2, 5],
                            profitData: [34, 28, 1, 5],
                            labels: ["1", '2', '2', '3'],
                            // tylko 2 pierwsze dni
                          ),
                ),
                SizedBox(
                  height: screenHeight * 1 / 4,
                  width: screenWidth * 8 / 16,

                  child:
                      vm.isDayMonthYear == 0
                          ? BarChartOne(
                            quantityData: [1, 2, 3, 4],
                            costData: [44, 22, 2, 5],
                            profitData: [34, 28, 1, 5],
                            labels: ["1", '2', '2', '3'],
                            // tylko 2 pierwsze dni
                          )
                          : vm.isDayMonthYear == 1
                          ? BarChartOne(
                            quantityData: [1, 2, 3, 4],
                            costData: [54, 45, 2, 5],
                            profitData: [34, 28, 1, 5],
                            labels: ["1", '2', '2', '3'],
                            // tylko 2 pierwsze dni
                          )
                          : BarChartOne(
                            quantityData: vm.totalMealsSoldList,
                            costData: [54, 45, 2, 5],
                            profitData: [34, 28, 1, 5],
                            labels: ["1", '2', '2', '3'],
                            // tylko 2 pierwsze dni
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
