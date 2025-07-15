class MealsModel {
  final List<String> listText;
  final List<String> listGram;
  final double thickness;

  MealsModel()
    : listText = [
        "Wartość energetyczna",
        "Tłuszcze",
        "w tym kwasy tłuszczowe nasycone",
        "Węglowodany",
        "w tym cukry",
        "Błonnik",
        "Białko",
        "Sól",
      ],
      listGram = [
        "kcal/100g",
        "g/100g",
        "g/100g",
        "g/100g",
        "g/100g",
        "g/100g",
        "g/100g",
        "g/100g",
      ],

      thickness = 2;
}
