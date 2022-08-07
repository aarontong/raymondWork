import 'dart:convert';

import 'package:gsheets/gsheets.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/action/inventoryModule.dart';
import 'package:private_project/action/productModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';
import 'package:private_project/model/product.dart';

class userCredentialsForGS {
  static const String _credentials = r'''
{
  "type": "service_account",
  "project_id": "eldoradowatch-c7c19-355810",
  "private_key_id": "aa3e5a04eac44039641d561e693e64d58ea9b31d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDGb9P0QhF5kyjW\n9fmOpYgy8vC0mc/YXFrIIq2QfYqbM0jRbD4NXcBcwJG2wz7cBsxZnbOqM/W3V5jz\na6q1aBXoqliCXgh6WdKmihHQmvwFIC6beU6aZRQB7WAHcCdJEskhK1i74yiUEA1d\nHRS8ZIMyiEr2E28W01cppngIsmr5ywDZw82FZ4kkTCQz2++9aOaATAsB2bSRTxtW\n9tXk1ApsWB7dRuoYfnGmL4EJkYvwp0GZiDOWO4y1EkPu7nGzvJSqGt6xFsfGN9f7\n3oAov6a0AKqeQc+7XTOAJKZM5lZ8ZWFext2hYPpkQCuUzszfrgyWIqWPxIeyX8za\nuTGNK2yLAgMBAAECggEAQNJqAioM7FKCrknW1l7DkaUjtVNjfpGYxDTzzrX777v+\nhw7dbF9aRdJQJ0w7fgOogIPQG4Lyuwwd9jKPJshUE9eFpzyRd2pdMjL7I9JlDkWX\nhAlKAIyRTxncW0GrS6cb1b6Ds4i+ijN+MhMcYXhSFVFJb34ktWefWwc6wdiKsoMn\nSDXGuo3wRmnF6wAX7ZHX0ZwU4RT3/4XQ35gHGA7CJTjjUGnXNpbWkzY31SInNKvL\nI94p9pE3QcUVfP0KZnG2KH3IKGJ4sJ4OVhgc1qCaw7cybGaUP/b6OJUfqPP+qThr\nPXGW+/ODg9Paslk2ohJXkIALqpc7tWdjKl6uLp+IxQKBgQDiKVWpN5xnhw05ggcg\nx+aICRo520RBNS3d55LKUwL+57/k1rWPUpTuW9o9rr0DLwDHZfUGXM/Cw/SVUhUK\nhjO91spdlhrgHj9pXeGDxjDhDSSE4Pp657UE8HlTBy372wtMeF2hoYepVecMfXsv\nSg5Bm+YC0NpyVoFrufRRanKu9wKBgQDgnhYPlsIlokR6rRJpBbDkdcXWbBQpRN+/\ne+ZgslZ37BbuibtWTsNrSlLVyulWOwdVFRKeoURamKpeiTVFS6GSoh7afQyGg+0u\nKA3rRTnJ71M44fu4T0rohfSQdz9twRrkCS48MLPprqOQms94KjaDofyKIPzv+hgR\nvhzNFUdGDQKBgQC7jKOo7KEbiXeCFT5sBNo8PbAuApObr8oVl5C3kBeP5AfSceum\nq0kuUaWuOVYtabEvqnGDkTwJvA78NVGVpK0L5S90ZKJs8SiM7HmzmYu3VfrO5vNR\nMQ2AxxsVq4KKtZ+tDrQ28Yla+A3e4cBh+vvPlMUt2J0O7IXvHApr6eapCQKBgQCf\nobor+giglmH0jWu4F8NPmiOv77+kVL5vZ66iqhupvq/NdzUccX2QkpGsPzj1f54G\naaOB+TqK6FSsOvcQ+F8rxuwGeziboMa/NtgtjFU1nlCW7IPoyPGDry/QO+9oIQTr\na1rgi/xQ5zx3WI556AY2JrlDsY4RPrw8X9A4MBcnQQKBgQCGi4fuiKq2KftlkGb6\nz7nFuB9NA/3Echv7C/Fpaire1aUsiToIntFFGmMvZ+kKm2eRzK1Z7i4Z/BcrGCqm\n2HruJBR3kVCg2h+tegkyYQXra1fxWU/id/kpQeFJOnIr1wVsegW3wjb8laVPEoXT\nnMhMV4vkU21zWyn0c2AuGgmhNw==\n-----END PRIVATE KEY-----\n",
  "client_email": "eldoradowatch@eldoradowatch-c7c19-355810.iam.gserviceaccount.com",
  "client_id": "101376067677633137554",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/eldoradowatch%40eldoradowatch-c7c19-355810.iam.gserviceaccount.com"
}''';
  static const String _sheetID = "1ShajYk2Mb_69VLwRto1FAYryvjf-B2vofblcbfFa3nk";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _customerSheet;
  static Worksheet? _inventorySheet;
  static Worksheet? _productSheet;

  static Future init() async {
    final spreadsheet = await _gsheets.spreadsheet(_sheetID);
    _customerSheet = await getWorksheet(spreadsheet, title: "Customer");
    final customerFirstRow = customerModule.getWorksheetTitle();
    _customerSheet!.values.insertRow(1, customerFirstRow);

    _inventorySheet = await getWorksheet(spreadsheet, title: "Inventory");
    final inventoryFirstRow = inventoryModule.getWorksheetTitle();
    _inventorySheet!.values.insertRow(1, inventoryFirstRow);

    _productSheet = await getWorksheet(spreadsheet, title: "Product");
    final productFirstRow = productModule.getWorksheetTitle();
    _productSheet!.values.insertRow(1, productFirstRow);
  }

  static Future<Worksheet> getWorksheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insertUser(Customer newCustomer) async {
    if (_customerSheet == null) return;
    await _customerSheet!.values.map.insertRowByKey(newCustomer.mobileNumber, newCustomer.toJson());
  }

  static Future<String> getAllUser() async {
    if (_customerSheet == null) return "";
    final users = await _customerSheet!.values.map.allRows();
    List<Customer> customerList = users!.map(Customer.fromJson).toList();
    String jsonString = jsonEncode(customerList);
    return users == null ? "" : jsonString;
  }

  static Future insertInventory(Inventory inventory) async {
    if (_inventorySheet == null) return;
    await _inventorySheet!.values.map.insertRowByKey(inventory.barCode, inventory.toJson());
  }

  static Future<String> getAllInventory() async {
    if (_inventorySheet == null) return "";
    final inventories = await _inventorySheet!.values.map.allRows();
    List<Inventory> inventoryList =
        inventories!.map(Inventory.fromJson).toList();
    String jsonString = jsonEncode(inventoryList);
    return inventories == null ? "" : jsonString;
  }

  static Future insertProduct(Product product) async {
    if (_productSheet == null) return;
    await _productSheet!.values.map.insertRowByKey(product.productCode, product.toJson());
  }

  static Future<String> getAllProduct() async {
    if (_productSheet == null) return "";
    final products = await _productSheet!.values.map.allRows();
    List<Inventory> productList = products!.map(Inventory.fromJson).toList();
    String jsonString = jsonEncode(productList);
    return products == null ? "" : jsonString;
  }

  static Future<Inventory?> searchInventoryCell() async{
    if(_inventorySheet == null) return null;
    final oldInventory = await _inventorySheet!.cells.findByValue("asdfdsafsdas");
    final editInventory = await _inventorySheet!.values.map.allRows();
    List<Inventory> inventoryList = editInventory!.map(Inventory.fromJson).toList();
    Inventory newInventory = inventoryList.elementAt(oldInventory.first.row - 2);
    return newInventory;
  }
}
