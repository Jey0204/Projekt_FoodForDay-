import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posilkiapp/Model/ApiClasses.dart';

class Addshiftviewmodel extends ChangeNotifier {
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

  String convertToTimeFormat(String input) {
    if (input.isEmpty) return '';

    try {
      double value = double.parse(input.replaceAll(',', '.'));
      int hour = value.floor();
      int minute = ((value - hour) * 60).round();

      // Zamknij wartości w 0-23 i 0-59, dla bezpieczeństwa
      if (hour < 0) hour = 0;
      if (hour > 23) hour = 23;
      if (minute < 0) minute = 0;
      if (minute > 59) minute = 59;

      // Sformatuj na "HH:mm:ss"
      String hourStr = hour.toString().padLeft(2, '0');
      String minuteStr = minute.toString().padLeft(2, '0');

      return '$hourStr:$minuteStr:00';
    } catch (e) {
      return ''; // jeśli nie uda się sparsować, zwróć pusty string
    }
  }

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
        fromTime = List.filled(canteen.length, '');
        toTime = List.filled(canteen.length, '');

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

  // Future<void> fetchCanteen() async {
  //   final url = Uri.parse('http://localhost:8080/api/Proxy/machine-info');
  //   isLoadingCanteen = true;
  //   errorCanteen = null;
  //   notifyListeners();

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final List data = json.decode(response.body);
  //       canteen = data.map((e) => CanteenInfo.fromJson(e)).toList();

  //       CanteenCheck = List.filled(canteen.length, false);
  //       fromTime = List.filled(canteen.length, '');
  //       toTime = List.filled(canteen.length, '');
  //       print("Pobrano ${canteen.length} stołówek");
  //     } else {
  //       errorCanteen = 'Błąd ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     errorCanteen = 'Błąd połączenia: $e';
  //   }

  //   isLoadingCanteen = false;
  //   notifyListeners();
  // }

  Future<void> fetchShift() async {
    final url = Uri.parse('http://localhost:8080/api/Meals/shift');
    isLoadingShift = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        shift = data.map((e) => Shift.fromJson(e)).toList();
      } else {
        error = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      error = 'Błąd połączenia: $e';
    }

    isLoadingShift = false;
    notifyListeners();
  }

  Future<void> saveShift(Shift shift) async {
    final url = Uri.parse("http://localhost:8080/api/Meals/shift");
    final body = jsonEncode(shift.toJson());

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

  void saveAll() {
    for (final s in shift.where((s) => s.check == true)) {
      s.name = name.text; // tutaj ustawiasz nazwę ze `vm.name`
      saveShift(s);
    }
  }
}
