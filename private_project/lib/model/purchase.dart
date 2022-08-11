import 'package:flutter/material.dart';
import 'package:private_project/action/inventoryAndPurchaseModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';

class Purchase {
  late List<Inventory> purchasedInventory;
  late String customerName;
  late String customerPhone;
  late Customer purchasedCustomer;
  late String soldTime;
  late String receiptID;

  Purchase(
      {Key? key,
      required this.purchasedInventory,
      required this.customerName,
      required this.customerPhone,
      required this.soldTime,
      required this.receiptID});
/*
  Purchase.fromJson(Map<String, dynamic> json)
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
      */
}
