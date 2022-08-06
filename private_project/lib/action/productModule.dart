import 'dart:convert';
import 'dart:io';
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:private_project/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class productModule {
  static String productCode = "productCode";
  static String productLine = "productLine";

  static final productModule _productModule = productModule.internal();
  static late int timestamp1;
  static String productListStringJson = "";
  late Product selectedProduct;
  factory productModule() {
    return _productModule;
  }
  productModule.internal();

  Future<void> addNewProduct(Product product) async {
    await userCredentialsForGS.insertProduct([product.toJson()]);

    await updateProductListCache();
  }

  static List<String> getWorksheetTitle() => [
        productCode,
        productLine,
      ];
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

  Future<String> updateProductListCache() async {
    productListStringJson = await userCredentialsForGS.getAllProduct();

    String fileName = "productListCache.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    file.writeAsStringSync(productListStringJson,
        flush: true, mode: FileMode.write);
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("productListCacheTime", timestamp1);
    return productListStringJson;
  }
}
