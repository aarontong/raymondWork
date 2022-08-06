import 'package:flutter/cupertino.dart';
import 'package:private_project/action/productModule.dart';

class Product extends ChangeNotifier{
  late String productCode;
  late String productLine;

  Product({
    Key? key,
    required this.productCode,
    required this.productLine,
  });

  Product.fromJson(Map<String, dynamic> json)
      : productCode = json["productCode"],
        productLine = json["productLine"];

  Map<String, dynamic> toJson() => {
        productModule.productCode: productCode,
        productModule.productLine: productLine,
      };
}
