import 'package:flutter/material.dart';
import 'package:private_project/widgets/inventory/addNewInventory.dart';
import 'package:private_project/widgets/inventory/inventoryListPage.dart';

class searchInventoryWidget extends StatefulWidget {
  const searchInventoryWidget({Key? key, required this.title})
      : super(key: key);
  final String title;
  static String route = "/searchInventoryWidget";

  @override
  State<searchInventoryWidget> createState() =>
      searchInventoryState(title: title);
}

class searchInventoryState extends State<searchInventoryWidget> {
  searchInventoryState({Key? key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, addNewInventoryWidget.route)
                  .then((_) => setState(() {}));
            },
            icon: Icon(Icons.add))
      ]),
      body: inventoryListPage(),
    );
  }
}
