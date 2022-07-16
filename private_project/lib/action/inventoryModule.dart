import 'package:firebase_database/firebase_database.dart';

import '../model/inventory.dart';

class inventoryModule {
  static final inventoryModule _inventoryModule = inventoryModule.internal();

  factory inventoryModule() {
    return _inventoryModule;
  }
  inventoryModule.internal();

  static Future<void> addNewInventory(
      Inventory inventory, String barCode) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Inventory");
    ref = ref.child(barCode);
    String productCode = inventory.productCode;
    String serialCode = inventory.serialCode;
    String description = inventory.description;

    await ref.set({
      "\"productCode\"": "\"$productCode\"",
      "\"serialCode\"": "\"$serialCode\"",
      "\"barCode\"": "\"$barCode\"",
      "\"description\"": "\"$description\"",
    });
  }
}
