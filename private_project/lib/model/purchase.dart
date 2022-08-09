import 'package:flutter/material.dart';
import 'package:private_project/action/inventoryAndPurchaseModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';

class purchase {
  late List<Inventory> purchasedInventory;
  late Customer customer;
  late DateTime soldTime;
  late String receiptID;

  purchase(
      {Key? key,
      required this.purchasedInventory,
      required this.customer,
      required this.soldTime,
      required this.receiptID});

  purchase.fromJson(Map<String, dynamic> json)
      : receiptID = json["receiptID"],
        customer = json["customer"],
        soldTime = json["soldTime"] == "" ? "" : json["soldTime"];

  Map<String, dynamic> toJson() => {
        inventoryAndPurchaseModule.receiptID: receiptID,
        inventoryAndPurchaseModule.customer: customer,
        inventoryAndPurchaseModule.soldTime: soldTime,
      };
}
