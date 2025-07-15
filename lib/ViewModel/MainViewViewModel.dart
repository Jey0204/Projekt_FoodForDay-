import 'package:flutter/material.dart';

class Mainviewviewmodel extends ChangeNotifier {
  bool isEditSelected = false;
  bool isAddMenuSelected = false;
  bool isAddShiftSelected = false;

  bool isAllergen = false;
  bool isGroup = false;
  bool isMeal = false;

  bool isRaport = false;
  bool isPlan = false;
  bool isKonfig = false;

  void allFalse() {
    isEditSelected = false;
    isAddMenuSelected = false;
    isAddShiftSelected = false;
    isRaport = false;
    isPlan = false;
    isKonfig = false;
    isAllergen = false;
    isGroup = false;
    isMeal = false;
    notifyListeners();
  }

  void togglePlan() {
    isPlan = !isPlan;
    notifyListeners();
  }

  void toggleEdit() {
    isEditSelected = !isEditSelected;
    notifyListeners();
  }

  void toggleKonfig() {
    isKonfig = !isKonfig;
    notifyListeners();
  }

  void toggleRaport() {
    isRaport = !isRaport;
    notifyListeners();
  }

  void toggleAddMenu() {
    isAddMenuSelected = !isAddMenuSelected;
    isEditSelected = false;
    isPlan = false;
    notifyListeners();
  }

  void toggleAddShift() {
    isAddShiftSelected = !isAddShiftSelected;
    isEditSelected = false;
    isPlan = false;
    notifyListeners();
  }

  void toggleAllergen() {
    isAllergen = !isAllergen;
    isEditSelected = false;
    isPlan = false;
    notifyListeners();
  }

  void toggleMeal() {
    isMeal = !isMeal;
    isEditSelected = false;
    isPlan = false;
    notifyListeners();
  }

  void toggleGroup() {
    isGroup = !isGroup;
    isEditSelected = false;
    isPlan = false;
    notifyListeners();
  }
}
