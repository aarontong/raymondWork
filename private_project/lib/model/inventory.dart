import 'package:flutter/cupertino.dart';
import 'package:private_project/action/inventoryModule.dart';

class Inventory {
  late String barCode;
  late String productCode;
  late String importTimeString;
  late String soldTimeString;
  late String purchaseCustomer;

  Inventory(
      {Key? key,
      required this.barCode,
      required this.productCode,
      required this.importTimeString,
      required this.soldTimeString,
      required this.purchaseCustomer});
  var epoch = new DateTime(1899, 12, 30);
  Inventory.fromJson(Map<String, dynamic> json)
      : barCode = json["barCode"],
        productCode = json["productCode"],
        purchaseCustomer = json["purchaseCustomer"],
        importTimeString = json["importTime"],
        soldTimeString = json["soldTime"] == "" ? "" : json["soldTime"];

  Map<String, dynamic> toJson() => {
        inventoryModule.barCode: barCode,
        inventoryModule.importTime: importTimeString,
        inventoryModule.soldTime: soldTimeString,
        inventoryModule.purchaseCustomer: purchaseCustomer,
        inventoryModule.productCode: productCode,
      };
}
