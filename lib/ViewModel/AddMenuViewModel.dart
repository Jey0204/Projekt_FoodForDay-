import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posilkiapp/Model/ApiClasses.dart';

class AddMenuviewmodel extends ChangeNotifier {
  List<Shift> shift = [];
  bool isLoadingShift = false;
  String? error;

  List<CanteenInfo> canteen = [];
  bool isLoadingCanteen = false;
  String? errorCanteen;

  List<bool> CanteenCheck = [];
  List<String> fromTime = [];
  List<String> toTime = [];

  TextEditingController name = TextEditingController();

  bool hasFetchedCanteens = false;
  bool hasFetchedData = false;

  String price = '';
  String mealName = '';

  String formattedDate = "";

  TextEditingController controllersName = TextEditingController();
  TextEditingController controllersPrice = TextEditingController();

  List<Menu> menu = [];

  void addDataToList() {
    shift.clear(); // Wyczyść starą listę przed dodaniem

    for (int i = 0; i < canteen.length; i++) {
      shift.add(
        Shift(
          name: '',
          timeStart: '',
          timeEnd: '',
          canteen: canteen[i].nameId,
          canteenName: canteen[i].name,
          check: true, // Możesz zachować info o zaznaczeniu
        ),
      );
    }

    notifyListeners();
  }

  Future<void> fetchCanteenInfo() async {
    if (hasFetchedCanteens) return;
    hasFetchedCanteens = true;
    final url = Uri.parse('http://localhost:8080/api/Proxy/machine-info');
    isLoadingCanteen = true;
    errorCanteen = null;
    notifyListeners();

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImthY3Blci5zb2JlazJAZ21haWwuY29tIiwiQ29tcGFueUlkIjoiYmIxMGVlODgtY2NjMC00NDQ3LTU5ZjAtMDhkOTM4ZDQ4ZmNkIiwibmJmIjoxNzUyMTQxNzY0LCJleHAiOjE3Njc2OTM3NjQsImp0aSI6ImY1YzcxOThkLWQ1MjUtNDhjOC05OTFjLTFiNjY2Njk1NmM3OSIsImlhdCI6MTc1MjE0MTc2NCwiQXBpIjoiVHJ1ZSIsIk1hY2hpbmVzUmVhZCI6IlRydWUiLCJNYWNoaW5lc1dyaXRlIjoiVHJ1ZSIsInJvbGUiOlsiQWRtaW4iLCJDb21wYW55T3duZXIiLCJTcGVjaWFsaXN0Il19.PhfLnxGLcoGCsVO7FhsVbYg4R0XqcvYerAEVT6rZDdA", // itd.
        }),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        canteen = data.map((e) => CanteenInfo.fromJson(e)).toList();
        CanteenCheck = List.filled(canteen.length, true);
        fetchShift();

        addDataToList();

        print(" Pobrano ${canteen.length} stołówek");
      } else {
        errorCanteen = ' Błąd ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      errorCanteen = 'Błąd połączenia: $e';
    }

    isLoadingCanteen = false;
    notifyListeners();
  }

  Future<void> fetchShift() async {
    final url = Uri.parse('http://localhost:8080/api/Meals/shift');
    isLoadingShift = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);

        shift =
            data.map((e) {
              final s = Shift.fromJson(e);
              s.check = true; // <- Ustawiamy check na true po sparsowaniu
              return s;
            }).toList();

        print(" Pobrano ${shift.length} zmian");
      } else {
        error = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      error = 'Błąd połączenia: $e';
    }

    isLoadingShift = false;
    notifyListeners();
  }

  Future<void> saveMenu(Menu menu) async {
    final url = Uri.parse("http://localhost:8080/api/Meals/menu");
    final body = jsonEncode(menu.toJson());

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Meal zapisany pomyślnie");
      } else {
        print("Błąd zapisu: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Błąd połączenia: $e");
    }
  }

  void generateMenuFromShifts() {
    menu.clear(); // wyczyść listę przed nowym generowaniem

    for (int i = 0; i < canteen.length; i++) {
      if (CanteenCheck.length > i && CanteenCheck[i]) {
        final selectedCanteen = canteen[i];

        final selectedShifts =
            shift
                .where(
                  (s) => s.canteen == selectedCanteen.nameId && s.check == true,
                )
                .toList();

        for (final s in selectedShifts) {
          menu.add(
            Menu(
              canteen: selectedCanteen.nameId,
              shiftId: s.id,
              isChecked: true,
            ),
          );
        }
      }
    }
  }

  void saveAll() {
    for (int i = 0; i < canteen.length; i++) {
      final canteenInfo = canteen[i];
      final isCanteenChecked =
          CanteenCheck.length > i ? CanteenCheck[i] : false;

      if (!isCanteenChecked) {
        continue;
      }

      final shiftsForCanteen =
          shift.where((s) => s.canteen == canteenInfo.nameId).toList();
      final selectedShifts =
          shiftsForCanteen.where((s) => s.check == true).toList();

      if (selectedShifts.isEmpty) {
        final menuItem = Menu(
          canteen: canteenInfo.nameId,
          shiftId: null,
          mealId: int.tryParse(controllersName.text),
          price: double.tryParse(controllersPrice.text),
          day: formattedDate,
        );
        saveMenu(menuItem);
      } else {
        for (final shift in selectedShifts) {
          final menuItem = Menu(
            canteen: canteenInfo.nameId,
            shiftId: shift.id,
            mealId: int.tryParse(controllersName.text),
            price: double.tryParse(controllersPrice.text),
            day: formattedDate,
          );
          saveMenu(menuItem);
        }
      }
    }
  }

  // void saveAll() {
  //   generateMenuFromShifts();
  //   for (final s in menu.where((s) => s.isChecked == true)) {
  //     s.mealId = 1; //controllersName.text; // trzeba dorobic id od posilku
  //     s.price = double.parse(controllersPrice.text);
  //     s.day = formattedDate;
  //     saveMenu(s);
  //   }
  // }
}
