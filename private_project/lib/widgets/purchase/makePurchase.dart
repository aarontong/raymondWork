import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/widgets/customer/insertField/relatedPersonField.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';
import 'package:provider/provider.dart';

class markPurchaseWidget extends StatefulWidget {
  const markPurchaseWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => markPurchaseState();
}

class markPurchaseState extends State<markPurchaseWidget> {
  static Customer newCustomer = Customer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    newCustomer = Customer();
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Customer>(
            create: (context) {
              return newCustomer;
            },
          ),
        ],
        child: Builder(builder: (BuildContext context) {
          BuildContext rootContext = context;
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                      child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: barCodeField()),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: relatedPersonField())
                          ])))));
        }));
  }
}
