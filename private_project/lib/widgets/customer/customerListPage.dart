import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/widgets/customer/insertField/relatedPersonField.dart';
import 'package:private_project/widgets/customer/searchCustomerInfo.dart';
import 'package:private_project/widgets/customer/searchPurchasedCustomer.dart';
import 'package:private_project/widgets/purchase/makePurchase.dart';

import '../../model/customer.dart';
import 'package:private_project/widgets/customer/searchCustomer.dart';

class customerListPage extends StatefulWidget {
  final bool multipleSelection, purchasing;
  const customerListPage(
      {Key? key, required this.multipleSelection, required this.purchasing})
      : super(key: key);
  static String route = "/customerListPage";

  @override
  State<customerListPage> createState() => customerListState();
}

class customerListState extends State<customerListPage> {
  late customerModule cm;
  int _value = -1;

  bool refetchOriginalList = true;

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
                if (refetchOriginalList) {
                  final androidDeviceInfo = snapshot.data;
                  if (androidDeviceInfo != "") {
                    customerList = [];
                    List parsed = jsonDecode(androidDeviceInfo!);
                    for (var v in parsed) {
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
                      itemCount: filteredCustomerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        String cardTitleString =
                            filteredCustomerList[index].enName +
                                "\t" +
                                filteredCustomerList[index].mobileNumber;
                        return ExpansionTile(
                          tilePadding: EdgeInsets.all(10),
                          title: widget.multipleSelection
                              ? CheckboxListTile(
                                  value: selectedCustomerList
                                      .contains(filteredCustomerList[index]),
                                  title: Text(cardTitleString),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (isChecked) => _itemChange(
                                      filteredCustomerList[index], isChecked!))
                              : widget.purchasing
                                  ? ListTile(
                                      title: Text(cardTitleString),
                                      leading: Radio(
                                        value: index,
                                        groupValue: _value,
                                        activeColor: Color(0xFF6200EE),
                                        onChanged: (value) {
                                          valueChanged(value as int);
                                        },
                                      ),
                                    )
                                  : Text(cardTitleString),
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
                                  filteredCustomerList[index].address),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text("Related Person:\t" +
                                  filteredCustomerList[index]
                                      .relatedPersonString),
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
        cm.currentSelectedCustomer.addRelatedPeople(itemValue);
      } else {
        selectedCustomerList.remove(itemValue);
        cm.currentSelectedCustomer.removeRelatedPeople(itemValue);
      }
      refetchOriginalList = false;
    });
  }

  Future<bool> _requestPop() {
    filteredCustomerList = [];
    customerList = [];
    selectedCustomerList = [];
    Navigator.pop(context);
    return new Future.value(true);
  }

  void valueChanged(int value) {
    setState(() {
      _value = value;
      cm.currentSelectedCustomer = filteredCustomerList[value];
    });
  }
}
