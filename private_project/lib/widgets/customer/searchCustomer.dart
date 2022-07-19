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
  static String searchWord = "";
  static List<Customer> customerList = [];
  static List<Customer> filteredCustomerList = [];
  static TextEditingController searchController = TextEditingController();
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
            if (searchWord == "") {
              filteredCustomerList = customerList;
            } else {
              filteredCustomerList = customerList
                  .where((Customer cust) =>
                      cust.mobileNumber.startsWith(searchWord))
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
                          hintText: 'Search Name or Phone Number',
                          border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          searchWord = value;
                        });
                      }),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        searchController.text = "";
                        searchWord = "";
                      });
                    },
                  ),
                ),
              ),
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'English Name\tMobile Number',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: List.generate(
                  filteredCustomerList.length,
                  (index) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                          Text(filteredCustomerList[index].enName +
                              "\t" +
                              filteredCustomerList[index].mobileNumber),
                          onTap: () {
                        customerModule cm = customerModule.searchCustomer();
                        cm.currentSelectedCustomer =
                            filteredCustomerList[index];
                        Navigator.of(context)
                            .pushNamed(searchCustomerInfo.route);
                      }),
                    ],
                  ),
                ),
              ),
            ])));
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
