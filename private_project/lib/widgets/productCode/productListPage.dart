import 'package:flutter/material.dart';
import 'package:private_project/action/productModule.dart';

class productListPage extends StatefulWidget {
  productListPage({Key? key, required this.title}) : super(key: key);

  String title = "Product Code List";
  static String route = "/productListPage";
  static TextEditingController productController = TextEditingController();
  @override
  State<productListPage> createState() => productListState();
}

class productListState extends State<productListPage> {
  late productModule pm;
  bool refetchOriginalList = true;

  static String searchWord = "";
  static List<String> selectedCustomerList = [];

  static List<String> inventoryList = [];
  static List<String> filteredInventoryList = [];
  static TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
