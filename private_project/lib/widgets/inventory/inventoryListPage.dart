import 'package:flutter/material.dart';
import 'package:private_project/action/inventoryModule.dart';
import 'package:private_project/model/inventory.dart';

class inventoryListPage extends StatefulWidget {
  const inventoryListPage({Key? key}) : super(key: key);
  static String route = "/inventoryListPage";

  @override
  State<inventoryListPage> createState() => inventoryListState();
}

class inventoryListState extends State<inventoryListPage> {
  late inventoryModule im;
  bool refetchOriginalList = true;

  static String searchWord = "";
  static List<Inventory> selectedCustomerList = [];

  static List<Inventory> customerList = [];
  static List<Inventory> filteredCustomerList = [];
  static TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Text("hello"),
    );
  }
}
