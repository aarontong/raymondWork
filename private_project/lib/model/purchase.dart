import 'package:flutter/material.dart';
import 'package:private_project/action/inventoryAndPurchaseModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';

class purchase {
  late List<Inventory> purchasedInventory;
  late String customerEnName;
  late String customerMobile;

  late DateTime soldTime;
  late String receiptID;

  purchase(
      {Key? key,
      required this.purchasedInventory,
      required this.customerEnName,
      required this.customerMobile,
      required this.soldTime,
      required this.receiptID});

  purchase.fromJson(Map<String, dynamic> json)
      : receiptID = json["receiptID"],
        customerEnName = json["customer name"],
        customerMobile = json["customer mobile"],
        soldTime = json["soldTime"] == "" ? "" : json["soldTime"];

  Map<String, dynamic> toJson() => {
        inventoryAndPurchaseModule.receiptID: receiptID,
        inventoryAndPurchaseModule.customerName: customerEnName,
        inventoryAndPurchaseModule.customerPhone: customerMobile,
        inventoryAndPurchaseModule.soldTime: soldTime,
      };
}
