import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/widgets/customer/searchCustomerInfo.dart';
import 'package:tableview/tableview.dart';
import 'package:private_project/widgets/customer/addNewCustomer.dart';

import '../../model/customer.dart';

class searchCustomerWidget extends StatefulWidget {
  const searchCustomerWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  static String route = "/searchCustomerWidget";

  @override
  State<searchCustomerWidget> createState() =>
      searchCustomerState(title: title);
}

class searchCustomerState extends State<searchCustomerWidget> {
  static List<Customer> customerList = [];
  static List<String> headerList = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "G",
    "H",
    "J",
    "K",
    "L",
    "M",
    "N",
    "P",
    "Q",
    "S",
    "T",
    "W",
    "X",
    "Y",
    "Z"
  ];

  final String title;
  searchCustomerState({Key? key, required this.title});
  var delegate = TableViewDelegate(numberOfSectionsInTableView: () {
    return 1;
  }, numberOfRowsInSection: (int section) {
    return customerList.length;
  }, heightForHeaderInSection: (int section) {
    return 0;
  }, heightForRowAtIndexPath: (IndexPath indexPath) {
    return 40;
  }, viewForHeaderInSection: (BuildContext context, int section) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      color: Color.fromRGBO(220, 220, 220, 1),
      height: 20,
      child: Text(headerList[section]),
    );
  }, cellForRowAtIndexPath: (BuildContext context, IndexPath indexPath) {
    String engName = customerList[indexPath.row].enName;
    String mobileNumber = customerList[indexPath.row].mobileNumber;

    return InkWell(
      onTap: () {
        customerModule cm = customerModule.searchCustomer();
        cm.currentSelectedCustomer = customerList[indexPath.row];
        Navigator.of(context).pushNamed(searchCustomerInfo.route);
      },
      child: Container(
        color: Colors.white,
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "$engName\tTel:$mobileNumber",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              height: 1,
            ),
          ],
        ),
      ),
    );
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    customerModule cm = customerModule.searchCustomer();
    customerList = [];
    return Scaffold(
      body: FutureBuilder<String>(
        future: cm.getCachedContent(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // data loaded:
            List<dynamic> tags;

            final androidDeviceInfo = snapshot.data;
            if (androidDeviceInfo != "") {
              Map<String, dynamic> parsed = jsonDecode(androidDeviceInfo!);
              for (var v in parsed.values) {
                Customer newCustomer = Customer.fromJson(v);
                customerList.add(newCustomer);
              }
              String hello = "";
            }

            return Center(
                child: Column(children: [
              /*
              Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                      
                      decoration: new InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {});
                      }),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),*/
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'English Name:',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: List.generate(
                  customerList.length,
                  (index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(customerList[index].enName), onTap: () {
                        customerModule cm = customerModule.searchCustomer();
                        cm.currentSelectedCustomer = customerList[index];
                        Navigator.of(context)
                            .pushNamed(searchCustomerInfo.route);
                      }),
                    ],
                  ),
                ),
              ),
            ]));
          }
        },
      ),
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, addNewCustomerWidget.route);
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
