import 'package:flutter/material.dart';
import 'package:posilkiapp/Model/MealsModel.dart';
import 'package:posilkiapp/View/Main/SquareButton.dart';
import 'package:posilkiapp/View/Meal/RowValuesView.dart';
import 'package:posilkiapp/View/Meal/RowView.dart';
import 'package:posilkiapp/ViewModel/MealsViewModel.dart';
import 'package:provider/provider.dart';

class MealsView extends StatefulWidget {
  const MealsView({super.key});

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  @override
  void initState() {
    super.initState();
    // opóźnione wywołanie fetchMeals po zbudowaniu widgetu
    Future.microtask(
      () =>
          Provider.of<MealsViewModel>(context, listen: false).fetchAllergens(),
    );
    Future.microtask(
      () => Provider.of<MealsViewModel>(context, listen: false).fetchCategory(),
    );
    Future.microtask(
      () => Provider.of<MealsViewModel>(context, listen: false).fetchGroups(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MealsViewModel>(context);
    final model = MealsModel();
    final squareButton = Squarebutton();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                Center(child: Text("Posiłki", style: TextStyle(fontSize: 30))),
                Positioned(
                  right: 25,
                  top: 0,
                  bottom: 0,
                  child: squareButton.buildSquareButtonText(
                    "Zapisz",
                    screenHeight,
                    screenWidth,
                    screenHeight / 50,
                    context,
                    () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // odstęp pod tytułem
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: vm.isActiv,
                            onChanged: (bool? value) {
                              vm.changeCheck();
                            },
                          ),
                          Text("Aktywny"),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 20),
                            Text("Nazwa"),
                            SizedBox(height: 20),
                            Text("Opis"),
                            SizedBox(height: 40),
                            Text("Nazwa"),
                            SizedBox(height: 20),
                            Text("Opis"),
                            SizedBox(height: 40),
                            Text("Nazwa"),
                            SizedBox(height: 20),
                            Text("Opis"),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text("PL"),
                            Container(
                              width: screenWidth / 6,
                              height: 40,
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                controller: vm.controllersNameDis[0],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth / 6,
                              height: 40,
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                controller: vm.controllersNameDis[1],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Text("EN"),
                            Container(
                              width: screenWidth / 6,
                              height: 40,
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                controller: vm.controllersNameDis[2],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth / 6,
                              height: 40,
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                controller: vm.controllersNameDis[3],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Text("DE"),
                            Container(
                              width: screenWidth / 6,
                              height: 40,
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                controller: vm.controllersNameDis[4],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth / 6,
                              height: 40,
                              child: TextField(
                                style: TextStyle(fontSize: 16),
                                controller: vm.controllersNameDis[5],
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth / 6,
                      child: Rowview(
                        leftButtonPressed: () {
                          print("Lewy przycisk kliknięty");
                        },
                        rightButtonPressed: () {
                          print("Prawy przycisk kliknięty");
                        },
                        mainButtonPressed: () {
                          print("Główny przycisk kliknięty");
                        },
                        bottomText: "Moje Logo",
                      ),
                    ),
                    Text("Alergeny"),
                    SizedBox(
                      height: screenHeight / 20,
                      width: screenWidth /
                          6, // zwiększ szerokość, by zmieściły się 2 kolumny
                      child: vm.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : vm.allergen.isEmpty
                              ? Center(child: Text("Brak alergenów"))
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // 2 kolumny
                                    childAspectRatio:
                                        3, // proporcje (szerokość/wysokość)
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: vm.allergen.length,
                                  itemBuilder: (context, index) {
                                    final allergen = vm.allergen[index];
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: vm.allergencheck[index],
                                          onChanged: (bool? value) {
                                            vm.allergencheck[index] =
                                                value ?? false;
                                            vm.notifyListeners(); // lub setState jeśli jesteś w StatefulWidget
                                          },
                                        ),
                                        Flexible(
                                          child: Text(
                                            allergen.Name ?? "Brak nazwy",
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
                SizedBox(width: 10), //zmienic dostosowac do ekranu
                SizedBox(
                  width: screenWidth / 3,
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenWidth / 3,
                        child: Rowvaluesview(
                          listText: model.listText,
                          gram: model.listGram,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Wartość"),
                          SizedBox(width: 50),
                          Container(
                            width: screenWidth / 8,
                            height: 40,
                            child: TextField(
                              style: TextStyle(fontSize: 16),
                              controller: vm.controllersNameDis[6],
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Text("zł"),
                          SizedBox(width: screenWidth / 9),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          squareButton.buildSquareButtonText(
                            "Dodaj zdjęcie",
                            screenHeight / 3,
                            screenWidth * 3 / 4,
                            screenHeight / 70,
                            context,
                            () {
                              vm.pickAndSaveFileImagine();
                            },
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: screenHeight / 12,
                            height: screenHeight / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 4.0),
                            ),
                            child: (vm.image != null)
                                ? Image.file(vm.image!, fit: BoxFit.cover)
                                : null,
                          ),
                          SizedBox(width: screenWidth / 9),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//blop
