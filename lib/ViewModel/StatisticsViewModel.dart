import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posilkiapp/Model/ApiClasses.dart';
import 'package:intl/intl.dart';

class Statisticsviewmodel extends ChangeNotifier {
  bool isData = false;
  String formattedDate = "";
  DateTime? selectedDay; // Class-level variable to persist selected day
  DateTime focusedDay = DateTime.now();
  String formattedYear = DateFormat('yyyy').format(DateTime.now()!);
  String formattedMonth = DateFormat('MM').format(DateTime.now()!);

  List<MealsStatusDay> mealsStatusDay = [];
  bool isLoadingStatusDay = false;
  String? errorStatusDay;

  List<MealsStatusMonth> mealsStatusmonth = [];
  bool isLoadingStatusMonth = false;
  String? errorStatusMonth;

  List<MealsStatusYear> mealsStatusYear = [];
  bool isLoadingStatusYear = false;
  String? errorStatusYear;

  List<int> totalMealsSoldList = [];
  List<double> totalPriceList = [];
  List<double> totalCostList = [];

  int isDayMonthYear = 0;

  void isDMY(int i) {
    isDayMonthYear = i;
    notifyListeners();
  }

  void dataChange() {
    isData = !isData;
    notifyListeners();
  }

  void goToNextDay() {
    focusedDay = focusedDay.add(const Duration(days: 1));
    getSelectedData(formattedDate);
    notifyListeners();
  }

  void goToPreviousDay() {
    focusedDay = focusedDay.subtract(const Duration(days: 1));
    getSelectedData(formattedDate);
    notifyListeners();
  }

  Future<void> getSelectedData(String data) async {
    final url = Uri.parse(
      'http://localhost:8080/api/Meals/stats/day?date=$data',
    );

    isLoadingStatusDay = true;
    errorStatusDay = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List decodedData = json.decode(response.body);

        mealsStatusDay =
            decodedData.map((e) => MealsStatusDay.fromJson(e)).toList();

        print(
          "Pobrano ${mealsStatusDay.length} rekordów posiłków dla dnia $data",
        );
      } else {
        errorStatusDay = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      errorStatusDay = 'Błąd połączenia: $e';
    }

    isLoadingStatusDay = false;
    notifyListeners();
  }

  Future<void> getSelectedMonth(
    String month,
    String year,
    String canteen,
  ) async {
    final url = Uri.parse(
      'http://localhost:8080/api/Meals/stats/months?year=$year&month=$month&canteen=$canteen',
    );

    isLoadingStatusMonth = true;
    errorStatusMonth = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List decodedData = json.decode(response.body);

        mealsStatusmonth =
            decodedData.map((e) => MealsStatusMonth.fromJson(e)).toList();

        print(
          "Pobrano ${mealsStatusmonth.length} rekordów posiłków dla dnia $month",
        );
      } else {
        errorStatusMonth = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      errorStatusMonth = 'Błąd połączenia: $e';
    }

    isLoadingStatusMonth = false;
    notifyListeners();
  }

  Future<void> getSelectedYear(String canteen) async {
    final url = Uri.parse(
      'http://localhost:8080/api/Meals/stats/years?canteen=$canteen',
    );

    isLoadingStatusYear = true;
    errorStatusYear = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> decodedData =
            json.decode(response.body) as List<dynamic>;
        print('Decoded data: $decodedData');

        mealsStatusYear =
            decodedData
                .map((e) => MealsStatusYear.fromJson(e as Map<String, dynamic>))
                .toList();

        print('mealsStatusYear length: ${mealsStatusYear.length}');
        if (mealsStatusYear.isNotEmpty) {
          print('First item year: ${mealsStatusYear.first.year}');
        }

        _createSeparateLists();
      } else {
        errorStatusYear = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      errorStatusYear = 'Błąd połączenia: $e';
    }
    isLoadingStatusYear = false;
    notifyListeners();
  }

  void _createSeparateLists() {
    print("do it");
    totalMealsSoldList =
        mealsStatusYear.map((item) => item.totalMealsSold ?? 0).toList();

    totalPriceList =
        mealsStatusYear.map((item) => item.totalPrice ?? 0.0).toList();

    totalCostList =
        mealsStatusYear.map((item) => item.totalCost ?? 0.0).toList();

    // Jeśli chcesz, możesz też wywołać notifyListeners(), jeśli te listy będą wykorzystywane w UI
    notifyListeners();
  }
}
