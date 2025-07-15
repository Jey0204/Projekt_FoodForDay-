import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posilkiapp/Model/ApiClasses.dart';

class MealsViewModel extends ChangeNotifier {
  List<Allergens> allergen = [];
  bool isLoading = false;
  String? error;

  List<Groups> groups = [];
  bool isLoadingGroup = false;

  List<Category> category = [];
  bool isLoadingCategry = false;

  List<ActivGroup> groupSelect = [];
  int? selectedGroupId;

  List<bool> allergencheck = [];
  bool isActiv = false;
  Uint8List? photoBlob;

  List<AllergensIsActiv> activAlergenChoosen = [];

  File? image;
  String? photoBase64;

  List<TextEditingController> controllers1 = [];
  List<TextEditingController> controllersNameDis = List.generate(
    7,
    (_) => TextEditingController(),
  );

  void initializeControllers(int count) {
    controllers1 = List.generate(count, (_) => TextEditingController());
  }

  void createFromAllergen(List<TextEditingController> controllers) async {
    if (controllers.length < 3) return;

    final newAllergen = Allergens(
      Id: 0,
      Name: controllers[0].text,
      NameEN: controllers[1].text,
      NameDE: controllers[2].text,
    );

    allergen.add(newAllergen);
    allergencheck.add(false);
    notifyListeners();

    final url = Uri.parse("http://localhost:8080/api/Meals/allergens");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": newAllergen.Id,
          "name": newAllergen.Name,
          "nameEN": newAllergen.NameEN,
          "nameDE": newAllergen.NameDE,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Allergen zapisany pomyślnie");
      } else {
        print("Błąd zapisu: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Błąd połączenia: $e");
    }
    loadAllergens();
    notifyListeners();
  }

  void createFromGroups(List<TextEditingController> controllers) async {
    if (controllers.length < 3) return;

    final newAllergen = Groups(
      Id: 0,
      Name: controllers[0].text,
      NameEN: controllers[1].text,
      NameDE: controllers[2].text,
    );

    groups.add(newAllergen);
    notifyListeners();

    final url = Uri.parse("http://localhost:8080/api/Meals/groups");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": newAllergen.Id,
          "name": newAllergen.Name,
          "nameEN": newAllergen.NameEN,
          "nameDE": newAllergen.NameDE,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Grupy zapisany pomyślnie");
        await fetchGroups();
      } else {
        print("Błąd zapisu: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Błąd połączenia: $e");
    }
  }

  Future<void> saveMeal(Meals meal) async {
    final url = Uri.parse("http://localhost:8080/api/Meals/meals");
    final body = jsonEncode(meal.toJson());

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

  void dataSave() {
    final allergens = [AllergensIsActiv(Id: 0, AllergenId: 0, IsActiv: true)];

    final values = [
      Values(
        Id: 0,
        Energetic:
            double.tryParse(controllers1[0].text.trim().replaceAll(',', '.')) ??
            0.0,
        Fats:
            double.tryParse(controllers1[1].text.trim().replaceAll(',', '.')) ??
            0.0,
        Saturated:
            double.tryParse(controllers1[2].text.trim().replaceAll(',', '.')) ??
            0.0,
        FattyAcids:
            double.tryParse(controllers1[3].text.trim().replaceAll(',', '.')) ??
            0.0,
        Sugars:
            double.tryParse(controllers1[4].text.trim().replaceAll(',', '.')) ??
            0.0,
        Fiber:
            double.tryParse(controllers1[5].text.trim().replaceAll(',', '.')) ??
            0.0,
        Protein:
            double.tryParse(controllers1[6].text.trim().replaceAll(',', '.')) ??
            0.0,
        Salt:
            double.tryParse(controllers1[7].text.trim().replaceAll(',', '.')) ??
            0.0,
        AllergensActiv: allergens,
      ),
    ];

    final meal = Meals(
      Id: 0,
      Name: controllersNameDis[0].text,
      NameEN: controllersNameDis[2].text,
      NameDE: controllersNameDis[4].text,
      group: 1, //selectedGroupId
      Activ: isActiv,
      ingrediens: [], // dopasuj, jeśli masz listę
      Photo: photoBlob,
      Description: controllersNameDis[1].text,
      DescriptionEN: controllersNameDis[3].text,
      DescriptionDE: controllersNameDis[5].text,
      value: values,
    );

    saveMeal(meal);
  }

  void loadAllergens() {
    allergencheck = List<bool>.filled(allergen.length, false, growable: true);

    notifyListeners();
  }

  void changeCheck() {
    isActiv = !isActiv;
    notifyListeners();
  }

  void fillGroupSelect() {
    groupSelect.clear(); // czyści starą zawartość

    // Przykład: jeśli masz listę `groups` typu List<Groups>
    groupSelect.addAll(
      groups.map(
        (group) => ActivGroup(Id: group.Id, name: group.Name ?? "Brak nazwy"),
      ),
    );

    for (var group in groupSelect) {
      print("Group: ${group.Id}, ${group.name}");
    }
  }

  Future<void> fetchCategory() async {
    final url = Uri.parse('http://localhost:8080/api/Meals/category');
    isLoadingCategry = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        category = data.map((e) => Category.fromJson(e)).toList();
      } else {
        error = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      error = 'Błąd połączenia: $e';
    }

    isLoadingCategry = false;
    notifyListeners();
  }

  Future<void> fetchGroups() async {
    final url = Uri.parse('http://localhost:8080/api/Meals/groups');
    isLoadingGroup = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        groups = data.map((e) => Groups.fromJson(e)).toList();

        fillGroupSelect();
      } else {
        error = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      error = 'Błąd połączenia: $e';
    }

    isLoadingGroup = false;
    notifyListeners();
  }

  Future<void> fetchAllergens() async {
    final url = Uri.parse('http://localhost:8080/api/Meals/allergens');
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        allergen = data.map((e) => Allergens.fromJson(e)).toList();
        loadAllergens();
        for (var a in allergen) {
          print('Allergen: ${a.Name}'); // zakładając, że masz pole `name`
        }
      } else {
        error = 'Błąd ${response.statusCode}';
      }
    } catch (e) {
      error = 'Błąd połączenia: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  String getHomeDir() {
    final home =
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    return home ?? '';
  }

  String getIsolifePath(String file) {
    final homeDir = getHomeDir();
    return Directory(homeDir).path +
        Platform.pathSeparator +
        "dataIsoLife" +
        Platform.pathSeparator +
        file;
  }

  // Future<void> pickAndSaveFileImagine() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     File selectedFile = File(result.files.single.path!);

  //     final bytes = await selectedFile.readAsBytes();
  //     photoBase64 = base64Encode(bytes);

  //     print("Zakodowany obraz base64: ${photoBase64!.substring(0, 30)}...");

  //     image = selectedFile; // dodaj nowy obraz do listy
  //     notifyListeners();
  //   } else {
  //     print('Nie wybrano pliku');
  //   }
  // }

  Future<void> pickAndSaveFileImagine() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File selectedFile = File(result.files.single.path!);

      final bytes = await selectedFile.readAsBytes();

      photoBlob = bytes; // Zapisz surowe bajty, nie base64!

      print("Obraz w formie BLOB, rozmiar: ${photoBlob!.length} bajtów");

      image = selectedFile;
      notifyListeners();
    } else {
      print('Nie wybrano pliku');
    }
  }
}
