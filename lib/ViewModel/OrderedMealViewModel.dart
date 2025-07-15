import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posilkiapp/Model/ApiClasses.dart';
import 'package:intl/intl.dart';

class Orderedmealviewmodel extends ChangeNotifier {
  DateTime focusedDay = DateTime.now();

  String get formattedDate => DateFormat('yyyy-MM-dd').format(focusedDay);

  List<MealsStatusDay> mealsStatusDay = [];
  bool isLoadingStatusDay = false;
  String? errorStatusDay;

  void goToNextDay() {
    focusedDay = focusedDay.add(const Duration(days: 1));
    fetchOrder(formattedDate);
    notifyListeners();
  }

  void goToPreviousDay() {
    focusedDay = focusedDay.subtract(const Duration(days: 1));
    fetchOrder(formattedDate);
    notifyListeners();
  }

  Future<void> fetchOrder(String data) async {
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
}
