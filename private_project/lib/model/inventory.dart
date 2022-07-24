import 'package:flutter/cupertino.dart';

class Inventory {
  late String barCode;
  late String productCode;
  late String description;
  late DateTime importTime;
  late String importTimeString;
  late DateTime sellTime;
  late String sellTimeString;

  Inventory({
    Key? key,
    required this.barCode,
    required this.productCode,
    required this.description,
    required this.importTime,
  });
  Inventory.fromJson(Map<String, dynamic> json)
      : barCode = json["barCode"],
        description = json["description"],
        productCode = json["productCode"],
        importTimeString = json["importTime"],
        sellTimeString = json["sellTime"];

  Map<String, dynamic> toJson() => {
        "barCode": barCode,
        "description": description,
        "productCode": productCode,
        "importTime": importTimeString,
        "sellTime": sellTimeString,
      };
}
