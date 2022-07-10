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
    await ref.set({
      "productCode": inventory.productCode,
      "serialCode": inventory.serialCode,
      "barCode": inventory.barCode,
      "description": inventory.description,
    });
  }
}
