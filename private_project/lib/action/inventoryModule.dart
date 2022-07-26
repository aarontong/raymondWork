import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/inventory.dart';

class inventoryModule {
  static final inventoryModule _inventoryModule = inventoryModule.internal();
  static late int timestamp1;
  static String inventoryListStringJson = "";

  factory inventoryModule() {
    return _inventoryModule;
  }
  inventoryModule.internal();

  static Future<void> addNewInventory(
      Inventory inventory, String barCode) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Inventory");
    ref = ref.child(barCode);
    String productCode = inventory.productCode;
    String description = inventory.description;
    String importTime =
        DateFormat('yyyy-MM-dd – kk:mm').format(inventory.importTime);

    await ref.set({
      "productCode": "$productCode",
      "barCode": "$barCode",
      "importTime": "$importTime",
      "description": "$description",
    });
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
      await updateInventoryListCache();
    }
    return inventoryListStringJson;
  }

  Future<void> updateInventoryListCache() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Inventory");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      Map map = snapshot.value as Map;
      inventoryListStringJson = json.encode(map);
      String fileName = "inventoryListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      file.writeAsStringSync(inventoryListStringJson,
          flush: true, mode: FileMode.write);
      DateTime nowDate = DateTime.now();
      timestamp1 = nowDate.millisecondsSinceEpoch;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("inventoryListCacheTime", timestamp1);
      String snapString = inventoryListStringJson;
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }
}
