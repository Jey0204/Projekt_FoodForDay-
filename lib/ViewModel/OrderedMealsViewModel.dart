import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posilkiapp/Model/ApiClasses.dart';

class Orderedmealsviewmodel extends ChangeNotifier {
  List<Allergens> allergen = [];
  bool isLoading = false;
  String? error;

  List<Groups> groups = [];
  bool isLoadingGroup = false;
}
