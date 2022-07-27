import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class productModule {
  static final productModule _productModule = productModule.internal();
  static late int timestamp1;
  static String productListStringJson = "";

  factory productModule() {
    return _productModule;
  }
  productModule.internal();

  static Future<void> addNewProduct(String productCode) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Product");
    await ref.set({
      "productCode": "$productCode",
    });
  }

  Future<String> getCachedContent() async {
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    int? cachedTime = prefs.getInt("productListCacheTime");
    cachedTime = cachedTime != null ? cachedTime : 0;
    int difference = timestamp1 - cachedTime;
    if (difference < 300000) {
      String fileName = "productListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      productListStringJson = await file.readAsString();
    } else {
      await updateProductListCache();
    }
    return productListStringJson;
  }

  Future<void> updateProductListCache() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Product");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      Map map = snapshot.value as Map;
      productListStringJson = json.encode(map);
      String fileName = "productListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      file.writeAsStringSync(productListStringJson,
          flush: true, mode: FileMode.write);
      DateTime nowDate = DateTime.now();
      timestamp1 = nowDate.millisecondsSinceEpoch;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("productListCacheTime", timestamp1);
      String snapString = productListStringJson;
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }
}
