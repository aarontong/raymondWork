import 'package:flutter/cupertino.dart';
import 'package:private_project/action/inventoryAndPurchaseModule.dart';

class Inventory {
  late String barCode;
  late String productCode;
  late String importTimeString;
  late String soldTime;
  late String customerPhone;
  late String customerName;
  late String receiptID;

  Inventory(
      {Key? key,
      required this.barCode,
      required this.productCode,
      required this.importTimeString,
      this.soldTime = "",
      this.customerPhone = "",
      this.customerName = "",
      this.receiptID = ""});
  var epoch = new DateTime(1899, 12, 30);
  Inventory.fromJson(Map<String, dynamic> json)
      : barCode = json["barCode"],
        productCode = json["productCode"],
        importTimeString = json["importTime"],
        soldTime = json["soldTime"],
        customerPhone = json["customer phone"],
        customerName = json["customer name"],
        receiptID = json["receiptID"];

  Map<String, dynamic> toJson() => {
        inventoryAndPurchaseModule.barCode: barCode,
        inventoryAndPurchaseModule.importTime: importTimeString,
        inventoryAndPurchaseModule.productCode: productCode,
        inventoryAndPurchaseModule.soldTime: soldTime,
        inventoryAndPurchaseModule.customerPhone: customerPhone,
        inventoryAndPurchaseModule.customerName: customerName,
        inventoryAndPurchaseModule.receiptID: receiptID
      };
}
