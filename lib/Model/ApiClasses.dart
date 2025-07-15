import 'dart:typed_data';

class Meals {
  final int? Id;
  final String? Name;
  final String? NameEN;
  final String? NameDE;
  final bool? Activ;
  final Uint8List? Photo;

  final String? Description;
  final String? DescriptionEN;
  final String? DescriptionDE;
  final List<Values>? value;
  final List<int>? ingrediens;
  final int? group;
  final double? price;

  Meals({
    this.Id,
    this.Activ,
    this.Description,
    this.DescriptionDE,
    this.DescriptionEN,
    this.Name,
    this.NameDE,
    this.NameEN,
    this.Photo,
    this.group,
    this.ingrediens,
    this.value,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": Id ?? 0,
      "name": Name ?? "",
      "nameEN": NameEN ?? "",
      "nameDE": NameDE ?? "",
      "group": group ?? 0, // pojedyncza liczba
      "activ": Activ ?? false,
      "ingrediens": ingrediens ?? [],
      "photo": Photo ?? "",
      "description": Description ?? "",
      "descriptionEN": DescriptionEN ?? "",
      "descriptionDE": DescriptionDE ?? "",
      "values": value?.map((v) => v.toJson()).toList() ?? [],
      "price": price ?? 0, // dodaj cenę, jeśli jest
    };
  }

  // factory Cell.fromJson(Map<String, dynamic> json) {
  //   return Cell(
  //     physicalVerticalAddress: json['physicalVerticalAddress'],
  //     workingCycleStatus: json['workingCycleStatus'],
  //     workingState: json['workingState'],
  //     sizeCharacter: json['sizeCharacter'],
  //   );
  // }
}

class Allergens {
  final int? Id;
  final String? Name;
  final String? NameDE;
  final String? NameEN;

  Allergens({this.Id, this.Name, this.NameDE, this.NameEN});

  factory Allergens.fromJson(Map<String, dynamic> json) {
    return Allergens(
      Id: json['id'],
      Name: json['name'],
      NameDE: json['nameDE'],
      NameEN: json['nameEN'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': Id, 'name': Name, 'nameEN': NameEN, 'nameDE': NameDE};
  }
}

class Category {
  final int? Id;
  final String? Name;
  final String? NameDE;
  final String? NameEN;

  Category({this.Id, this.Name, this.NameDE, this.NameEN});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      Id: json['id'],
      Name: json['name'],
      NameDE: json['nameDE'],
      NameEN: json['nameEN'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': Id, 'name': Name, 'nameEN': NameEN, 'nameDE': NameDE};
  }
}

class Groups {
  final int? Id;
  final String? Name;
  final String? NameDE;
  final String? NameEN;

  Groups({this.Id, this.Name, this.NameDE, this.NameEN});

  factory Groups.fromJson(Map<String, dynamic> json) {
    return Groups(
      Id: json['id'],
      Name: json['name'],
      NameDE: json['nameDE'],
      NameEN: json['nameEN'],
    );
  }
}

class ActivGroup {
  final int? Id;
  final String? name;
  ActivGroup({this.Id, this.name});
}

class AllergensIsActiv {
  final int? Id;
  final int? AllergenId;
  final bool? IsActiv;

  AllergensIsActiv({this.AllergenId, this.Id, this.IsActiv});

  Map<String, dynamic> toJson() {
    return {
      "id": Id ?? 0,
      "allergenId": AllergenId ?? 0,
      "isActiv": IsActiv ?? false,
    };
  }
}

class Values {
  final int? Id;
  final double? Energetic;
  final double? Fats;
  final double? Saturated;
  final double? FattyAcids;
  final double? Sugars;
  final double? Fiber;
  final double? Protein;
  final double? Salt;
  final List<AllergensIsActiv>? AllergensActiv;

  Values({
    this.Energetic,
    this.Fats,
    this.Id,
    this.FattyAcids,
    this.Fiber,
    this.Protein,
    this.Salt,
    this.Saturated,
    this.Sugars,
    this.AllergensActiv,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": Id ?? 0,
      "energetic": Energetic ?? "0",
      "fats": Fats ?? "0",
      "saturated": Saturated ?? "0",
      "fattyAcids": FattyAcids ?? "0",
      "sugars": Sugars ?? "0",
      "fiber": Fiber ?? "0",
      "protein": Protein ?? "0",
      "salt": Salt ?? "0",
      "allergensActivs": AllergensActiv?.map((a) => a.toJson()).toList() ?? [],
    };
  }
}

class Shift {
  final int? id;
  String? name;
  String? timeStart;
  String? timeEnd;
  final String? canteen;
  final String? canteenName;
  bool? check;

  Shift({
    this.canteen,
    this.id,
    this.name,
    this.timeEnd,
    this.timeStart,
    this.check,
    this.canteenName,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "name": name ?? "0",
      "timeStart": timeStart ?? "0",
      "timeEnd": timeEnd ?? "0",
      "canteen": canteen ?? "0",
    };
  }

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      name: json['name'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      canteen: json['canteen'],
    );
  }
}

class CanteenInfo {
  final String? nameId;
  final String? name;

  CanteenInfo({this.name, this.nameId});

  factory CanteenInfo.fromJson(Map<String, dynamic> json) {
    return CanteenInfo(nameId: json['id'], name: json['name']);
  }
}

class Menu {
  final int? id;
  String? day;
  final int? shiftId;
  final String? canteen;
  int? mealId;
  double? price;
  bool? isChecked;

  Menu({
    this.canteen,
    this.day,
    this.id,
    this.mealId,
    this.price,
    this.shiftId,
    this.isChecked,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "day": day ?? "0",
      "shiftId": shiftId ?? 0,
      "canteen": canteen ?? "0",
      "mealId": mealId ?? 0,
      "price": price ?? 0.0,
    };
  }
}

class Order {
  final int? Id;
  final int? ClientId;
  final String? Canteen;
  final int? Shift;
  final String? DateTime;
  final int? State;

  Order({
    this.Canteen,
    this.ClientId,
    this.DateTime,
    this.Id,
    this.Shift,
    this.State,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      Id: json['id'],
      ClientId: json['clientId'],
      Canteen: json['canteen'],
      Shift: json['shift'],
      DateTime: json['dateTime'],
      State: json['state'],
    );
  }
}

class MealsLocation {
  final int? Id;
  final int? OrderId;
  final int? MealId;
  final double? Price;
  final double? Cost;
  final int? X;
  final int? Y;

  MealsLocation({
    this.Cost,
    this.Id,
    this.MealId,
    this.OrderId,
    this.Price,
    this.X,
    this.Y,
  });

  factory MealsLocation.fromJson(Map<String, dynamic> json) {
    return MealsLocation(
      Id: json['id'],
      OrderId: json['orderId'],
      MealId: json['mealId'],
      Price: json['price'],
      Cost: json['cost'],
      X: json['x'],
      Y: json['y'],
    );
  }
}

class MealsStatusDay {
  final String? name;
  final int? number;
  final double? price;
  final double? cost;
  final int? shiftId;

  MealsStatusDay({this.name, this.number, this.price, this.cost, this.shiftId});

  factory MealsStatusDay.fromJson(Map<String, dynamic> json) {
    return MealsStatusDay(
      name: json['mealName'],
      number: json['quantity'],
      price: (json['price'] as num?)?.toDouble(),
      cost: (json['cost'] as num?)?.toDouble(),
      shiftId: json['shiftId'],
    );
  }
}

class MealsStatusMonth {
  final int? totalMealsSold;
  final double? totalPrice;
  final double? totalCost;
  final int? year;
  final int? month;

  MealsStatusMonth({
    this.totalCost,
    this.totalMealsSold,
    this.totalPrice,
    this.month,
    this.year,
  });

  factory MealsStatusMonth.fromJson(Map<String, dynamic> json) {
    return MealsStatusMonth(
      totalMealsSold: json['totalMealsSold'],
      totalPrice: json['totalPrice'],
      totalCost: json['totalCost'],
      month: json['month'],
      year: json['year'],
    );
  }
}

class MealsStatusYear {
  final int? totalMealsSold;
  final double? totalPrice;
  final double? totalCost;
  final int? year;
  final int? month;

  MealsStatusYear({
    this.totalCost,
    this.totalMealsSold,
    this.totalPrice,
    this.year,
    this.month,
  });

  factory MealsStatusYear.fromJson(Map<String, dynamic> json) {
    return MealsStatusYear(
      totalMealsSold: json['totalMealsSold'],
      totalPrice: json['totalPrice'],
      totalCost: json['totalCost'],
      year: json["year"],
      month: json['month'],
    );
  }
}
