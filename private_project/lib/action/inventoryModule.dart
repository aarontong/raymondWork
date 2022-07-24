import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

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
}
