import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';
import 'package:private_project/widgets/customer/insertField/relatedPersonField.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';
import 'package:private_project/widgets/purchase/makePurchaseButton.dart';
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
                                child: makePurchaseButton(pressedButton: submitButtonPressed,))
                          ])))));
        }));
  }

  Future<void> submitButtonPressed() async {
    String barcodeText = barCodeField.barCodeFieldController.text;
    
    if (barcodeText == "") {
      _showAlertDialog();
    } else {
      
      Inventory? editInventory = await userCredentialsForGS.searchInventoryCell();

      _showSuccessDialog().then((value) => Navigator.pop(context));
    }
  }

  Future<void> _showAlertDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Widget okAction = TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // dismiss dialog
            },
          );

          return AlertDialog(
            title: Text("Input Missing"),
            content: Text("Please enter data in all fields"),
            actions: [
              okAction,
            ],
          );
        });
  }

  Future<void> _showSuccessDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Widget okAction = TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          );

          return AlertDialog(
            title: Text("Input Success"),
            content: Text("Customer info has been saved"),
            actions: [
              okAction,
            ],
          );
        });
  }
}
