import 'dart:convert';

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

  static List<String> productList = [];
  static List<String> filteredProductList = [];
  static TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pm = productModule();
    // TODO: implement build
    return new WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: new AppBar(
              title: Text(widget.title),
            ),
            body: FutureBuilder<String>(
                future: pm.getCachedContent(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final androidDeviceInfo = snapshot.data;
                    if (androidDeviceInfo != "") {
                      productList = [];
                      Map parsed = jsonDecode(androidDeviceInfo!);
                      for (var v in parsed.values) {
                        productList.add(v.toString());
                      }
                      String hello = "";
                    }
                    if (searchWord == "") {
                      filteredProductList = productList;
                    } else {
                      filteredProductList = productList
                          .where((String productCode) =>
                              productCode.startsWith(searchWord))
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
                                  hintText: 'Search Product Code',
                                  border: InputBorder.none),
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
                          itemCount: filteredProductList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new GestureDetector(
                                //You need to make my child interactive
                                onTap: () =>
                                    _itemChange(filteredProductList[index]),
                                child: ListTile(
                                  title: Text(filteredProductList[index]),
                                ));
                          }),
                    ])));
                  }
                })));
  }

  void _itemChange(String value) {
    pm.selectedProduceCode = value;
  }

  Future<bool> _requestPop() {
    filteredProductList = [];
    productList = [];
    return new Future.value(true);
  }
}
