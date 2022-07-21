import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/widgets/customer/searchCustomerInfo.dart';
import '../../model/customer.dart';

class customerListPage extends StatefulWidget {
  final bool multipleSelection;
  const customerListPage({Key? key, required this.multipleSelection})
      : super(key: key);
  static String route = "/customerListPage";

  @override
  State<customerListPage> createState() => customerListState();
}

class customerListState extends State<customerListPage> {
  late customerModule cm;
  static String searchWord = "";
  static List<Customer> selectedCustomerList = [];

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

  @override
  Widget build(BuildContext context) {
    cm = customerModule.searchCustomer();
    // TODO: implement build
    return new WillPopScope(
        onWillPop: _requestPop,
        child: new Scaffold(
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
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredCustomerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                          tilePadding: EdgeInsets.all(10),
                          title: widget.multipleSelection
                              ? CheckboxListTile(
                                  value: selectedCustomerList
                                      .contains(filteredCustomerList[index]),
                                  title: Text(filteredCustomerList[index]
                                          .enName +
                                      "\t" +
                                      filteredCustomerList[index].mobileNumber),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (isChecked) => _itemChange(
                                      filteredCustomerList[index], isChecked!))
                              : Text(filteredCustomerList[index].enName +
                                  "\t" +
                                  filteredCustomerList[index].mobileNumber),
                          children: [
                            ListTile(
                              title: Text("English Name:\t" +
                                  filteredCustomerList[index].enName),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text("Chinese Name:\t" +
                                  filteredCustomerList[index].chName),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text("Mobile:\t" +
                                  filteredCustomerList[index].mobileNumber),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text("Email:\t" +
                                  filteredCustomerList[index].email),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text("Profession:\t" +
                                  filteredCustomerList[index].profession),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text(
                                  "Age:\t" + filteredCustomerList[index].age),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text("Home Address:\t" +
                                  filteredCustomerList[index].homeAddress),
                            ),
                            SizedBox(height: 10),
                            Image.network(
                              filteredCustomerList[index].profileImageURL,
                              width: 150,
                              height: 150,
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      }),
                ])));
              }
            },
          ),
        ));
  }

  void _itemChange(Customer itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedCustomerList.add(itemValue);
      } else {
        selectedCustomerList.remove(itemValue);
      }
    });
  }

  Future<bool> _requestPop() {
    cm.relatedPerson = [];
    filteredCustomerList = [];
    customerList = [];
    selectedCustomerList = [];
    return new Future.value(true);
  }
}
