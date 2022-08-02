import 'dart:convert';

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

  static List<Inventory> inventoryList = [];
  static List<Inventory> filteredInventoryList = [];
  static TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    im = inventoryModule();

    // TODO: implement build
    return new Scaffold(
        body: FutureBuilder<String>(
      future: im.getCachedContent(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final androidDeviceInfo = snapshot.data;
          if (androidDeviceInfo != "") {
            inventoryList = [];
            List parsed = jsonDecode(androidDeviceInfo!);
            for (var v in parsed) {
              Inventory newInventory = Inventory.fromJson(v);
              inventoryList.add(newInventory);
            }
            String hello = "";
          }
          if (searchWord == "") {
            filteredInventoryList = inventoryList;
          } else {
            filteredInventoryList = inventoryList
                .where((Inventory inventory) =>
                    inventory.barCode.startsWith(searchWord))
                .toList();
          }
          return SingleChildScrollView(
              child: Center(
                  child: Column(children: [
            Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                    controller: searchController,
                    decoration: new InputDecoration(
                        hintText: 'Search Bar Code', border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                        refetchOriginalList = true;
                        searchWord = value;
                      });
                    }),
                trailing: new IconButton(
                  icon: new Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      refetchOriginalList = true;
                      searchController.text = "";
                      searchWord = "";
                    });
                  },
                ),
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredInventoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    tilePadding: EdgeInsets.all(10),
                    title: Text(filteredInventoryList[index].barCode),
                    children: [
                      ListTile(
                        title: Text("Bar Code:\t" +
                            filteredInventoryList[index].barCode),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }),
          ])));
        }
      },
    ));
  }
}
