import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/widgets/customer/searchCustomerInfo.dart';
import '../../model/customer.dart';

class customerListPage extends StatefulWidget {
  const customerListPage({Key? key, required this.title}) : super(key: key);
  final String title;
  static String route = "/customerListPage";

  @override
  State<customerListPage> createState() => customerListState(title: title);
}

class customerListState extends State<customerListPage> {
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
  customerListState({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    customerModule cm = customerModule.searchCustomer();

    // TODO: implement build
    return new Scaffold(
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
    );
  }
}
