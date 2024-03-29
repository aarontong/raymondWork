import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/inventory.dart';

class inventoryAndPurchaseModule {
  static String barCode = "barCode";
  static String importTime = "importTime";
  static String soldTime = "soldTime";
  static String customerPhone = "customer phone";
  static String customerName = "customer name";

  static String productCode = "productCode";
  static String receiptID = "receiptID";

  static final inventoryAndPurchaseModule _inventoryAndPurchaseModule =
      inventoryAndPurchaseModule.internal();
  static late int timestamp1;
  static String inventoryListStringJson = "";

  factory inventoryAndPurchaseModule() {
    return _inventoryAndPurchaseModule;
  }
  inventoryAndPurchaseModule.internal();

  static List<String> getWorksheetTitle() => [
        barCode,
        importTime,
        productCode,
        soldTime,
        customerPhone,
        customerName,
        receiptID
      ];
  Future<void> addNewInventory(Inventory inventory, String barCode) async {
    await userCredentialsForGS.insertInventory(inventory);

    await updateInventoryListCache();
  }

  Future<String> getCachedContent() async {
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    int? cachedTime = prefs.getInt("inventoryListCacheTime");
    cachedTime = cachedTime != null ? cachedTime : 0;
    int difference = timestamp1 - cachedTime;
    if (difference < 300000) {
      String fileName = "inventoryListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      inventoryListStringJson = await file.readAsString();
    } else {
      inventoryListStringJson = await updateInventoryListCache();
    }
    return inventoryListStringJson;
  }

  Future<String> updateInventoryListCache() async {
    String inventoryListStringJson =
        await userCredentialsForGS.getAllInventory();
    String fileName = "inventoryListCache.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    file.writeAsStringSync(inventoryListStringJson,
        flush: true, mode: FileMode.write);
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("inventoryListCacheTime", timestamp1);
    return inventoryListStringJson;
  }
}
