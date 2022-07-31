import 'package:flutter/cupertino.dart';
import 'package:private_project/action/inventoryModule.dart';

class Inventory {
  late String barCode;
  late String productCode;
  late String description;
  late DateTime importTime;
  late String importTimeString;
  late DateTime sellTime;
  late String sellTimeString;
  late String purchaseCustomer;

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
        inventoryModule.barCode: barCode,
        inventoryModule.importTime: importTimeString,
        inventoryModule.soldTime: sellTime,
        inventoryModule.purchaseCustomer: purchaseCustomer,
        inventoryModule.description: description,
      };
}
