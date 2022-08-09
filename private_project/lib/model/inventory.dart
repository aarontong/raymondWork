import 'package:flutter/cupertino.dart';
import 'package:private_project/action/inventoryAndPurchaseModule.dart';

class Inventory {
  late String barCode;
  late String productCode;
  late String importTimeString;

  Inventory(
      {Key? key,
      required this.barCode,
      required this.productCode,
      required this.importTimeString});
  var epoch = new DateTime(1899, 12, 30);
  Inventory.fromJson(Map<String, dynamic> json)
      : barCode = json["barCode"],
        productCode = json["productCode"],
        importTimeString = json["importTime"];

  Map<String, dynamic> toJson() => {
        inventoryAndPurchaseModule.barCode: barCode,
        inventoryAndPurchaseModule.importTime: importTimeString,
        inventoryAndPurchaseModule.productCode: productCode,
      };
}
