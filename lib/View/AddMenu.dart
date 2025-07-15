import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/ViewModel/AddMenuViewModel.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Addmenu extends StatelessWidget {
  const Addmenu({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddMenuviewmodel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchCanteenInfo();
    });
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    DateTime? selectedDay; // Class-level variable to persist selected day
    DateTime focusedDay = DateTime.now();
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
                    child: Text(
                      "Dodaj jadłospis",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Positioned(
                    right: 25,
                    top: 0,
                    bottom: 0,
                    child: squareButton.buildSquareButtonText(
                      "Dodaj",
                      screenHeight,
                      screenWidth,
                      screenHeight / 50,
                      context,
                      () {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Posiłek"),
                    Container(
                      width: screenWidth * 3 / 16,
                      height: 40,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        controller: vm.controllersName,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Text("Cena"),
                    Container(
                      width: screenWidth * 3 / 16,
                      height: 40,
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        controller: vm.controllersPrice,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 3 / 16,
                      height: screenHeight * 7 / 16,
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return TableCalendar(
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: focusedDay,
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: const Color.fromARGB(255, 79, 135, 0),
                                shape: BoxShape.circle,
                              ),
                            ),
                            selectedDayPredicate: (day) {
                              return isSameDay(selectedDay, day);
                            },
                            calendarFormat: CalendarFormat.month,
                            headerStyle: HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                            ),
                            onDaySelected: (newSelectedDay, newFocusedDay) {
                              setState(() {
                                selectedDay = newSelectedDay;
                                focusedDay = newFocusedDay;
                              });

                              vm.formattedDate = DateFormat(
                                'yyyy-MM-dd',
                              ).format(selectedDay!);

                              print(vm.formattedDate);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),

                SizedBox(
                  width: (screenWidth - 30) * 1 / 4,
                  height: screenHeight / 2,
                  child: ListView.builder(
                    itemCount: vm.canteen.length,
                    itemBuilder: (context, index) {
                      final canteen = vm.canteen[index];
                      // filtrujemy zmiany tylko dla tego automatu
                      final shiftsForCanteen = vm.shift
                          .where((shift) => shift.canteen == canteen.nameId)
                          .toList();

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox + nazwa automatu
                            Row(
                              children: [
                                Checkbox(
                                  value: vm.CanteenCheck.length > index
                                      ? vm.CanteenCheck[index]
                                      : false,
                                  onChanged: (val) {
                                    vm.CanteenCheck[index] = val ?? false;
                                    vm.notifyListeners();
                                  },
                                ),
                                Text(canteen.name ?? ''),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                children: shiftsForCanteen.map((shift) {
                                  return Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(screenWidth / 30),
                                      1: FixedColumnWidth(screenWidth / 12),
                                      2: FixedColumnWidth(screenWidth / 10),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Checkbox(
                                            value: shift.check ?? false,
                                            onChanged: (val) {
                                              shift.check = val ?? false;
                                              vm.notifyListeners();
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Text(
                                              shift.name!.isNotEmpty
                                                  ? shift.name!
                                                  : 'Brak nazwy',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Text(
                                              '${shift.timeStart} - ${shift.timeEnd}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),

                            // Lista zmian dla automatu z checkboxami
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 30.0),
                            //   child: Column(
                            //     children:
                            //         shiftsForCanteen.map((shift) {
                            //           // W tym miejscu musisz przechowywać checkboxy dla shiftów (np. w osobnej liście booli)
                            //           // Na potrzeby demo przyjmijmy, że mają wartość true
                            //           return Row(
                            //             children: [
                            //               Checkbox(
                            //                 value: shift.check ?? false,
                            //                 onChanged: (val) {
                            //                   shift.check = val ?? false;
                            //                   vm.notifyListeners();
                            //                 },
                            //               ),

                            //               Text(
                            //                 shift.name!.isNotEmpty
                            //                     ? shift.name!
                            //                     : 'Brak nazwy',
                            //               ),

                            //               SizedBox(width: 8),
                            //               Text(
                            //                 '${shift.timeStart} - ${shift.timeEnd}',
                            //               ),
                            //             ],
                            //           );
                            //         }).toList(),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ///////jesli nie ma zmian nie ma automatow
                // SizedBox(
                //   width: (screenWidth - 30) * 1 / 4,
                //   height: screenHeight / 2,
                //   child: ListView.builder(
                //     itemCount: vm.canteen.length,
                //     itemBuilder: (context, index) {
                //       final canteen = vm.canteen[index];
                //       final shiftsForCanteen =
                //           vm.shift
                //               .where((shift) => shift.canteen == canteen.nameId)
                //               .toList();

                //       // Jeśli brak zmian, nic nie pokazuj
                //       if (shiftsForCanteen.isEmpty) {
                //         return SizedBox.shrink();
                //       }

                //       return Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             // Checkbox + nazwa automatu
                //             Row(
                //               children: [
                //                 Checkbox(
                //                   value:
                //                       vm.CanteenCheck.length > index
                //                           ? vm.CanteenCheck[index]
                //                           : false,
                //                   onChanged: (val) {
                //                     vm.CanteenCheck[index] = val ?? false;
                //                     vm.notifyListeners();
                //                   },
                //                 ),
                //                 Text(canteen.name ?? ''),
                //               ],
                //             ),
                //             // Lista zmian dla automatu z checkboxami
                //             Padding(
                //               padding: const EdgeInsets.only(left: 30.0),
                //               child: Column(
                //                 children:
                //                     shiftsForCanteen.map((shift) {
                //                       return Row(
                //                         children: [
                //                           Checkbox(
                //                             value: shift.check ?? false,
                //                             onChanged: (val) {
                //                               shift.check = val ?? false;
                //                               vm.notifyListeners();
                //                             },
                //                           ),
                //                           Text(
                //                             (shift.name?.isNotEmpty ?? false)
                //                                 ? shift.name!
                //                                 : 'Brak nazwy',
                //                           ),
                //                           SizedBox(width: 8),
                //                           Text(
                //                             '${shift.timeStart} - ${shift.timeEnd}',
                //                           ),
                //                         ],
                //                       );
                //                     }).toList(),
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
