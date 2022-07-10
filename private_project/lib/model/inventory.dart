import 'package:flutter/cupertino.dart';

class Inventory {
  late String serialCode;
  late String barCode;
  late String productCode;
  late String description;

  Inventory({
    Key? key,
    required this.serialCode,
    required this.barCode,
    required this.productCode,
    required this.description,
  });
}
