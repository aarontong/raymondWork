import 'package:flutter/cupertino.dart';

class Product {
  late String serialCode;
  late String barCode;
  late String productCode;

  Product({
    Key? key,
    required this.serialCode,
    required this.barCode,
    required this.productCode,
  });
}
