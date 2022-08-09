import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:private_project/action/inventoryAndPurchaseModule.dart';
import 'package:private_project/model/inventory.dart';

class inventoryListPage extends StatefulWidget {
  const inventoryListPage({Key? key}) : super(key: key);
  static String route = "/inventoryListPage";

  @override
  State<inventoryListPage> createState() => inventoryListState();
}

class inventoryListState extends State<inventoryListPage> {
  late inventoryAndPurchaseModule im;
  bool refetchOriginalList = true;

  static String searchWord = "";
  static List<Inventory> selectedCustomerList = [];

  static List<Inventory> inventoryList = [];
  static List<Inventory> filteredInventoryList = [];
  static TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    im = inventoryAndPurchaseModule();

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
                      ListTile(
                        title: Text("Product Code:\t" +
                            filteredInventoryList[index].productCode),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text("Import Time:\t" +
                            filteredInventoryList[index].importTimeString),
                      ),
                      SizedBox(height: 10),
                      /*
                      ListTile(
                        title: Text("Sold Time:\t" +
                            filteredInventoryList[index].soldTimeString),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text("Purchased By:\t" +
                            filteredInventoryList[index].customer),
                      ),
                      SizedBox(height: 10),
                      */
                    ],
                  );
                }),
          ])));
        }
      },
    ));
  }
}
