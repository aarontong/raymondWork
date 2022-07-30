import 'package:flutter/material.dart';
import 'package:private_project/action/inventoryModule.dart';
import 'package:private_project/widgets/inventory/insertField/addInventoryButton.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';
import 'package:private_project/widgets/inventory/insertField/descriptionFIeld.dart';
import 'package:private_project/widgets/inventory/insertField/productCodeField.dart';

import '../../model/inventory.dart';

class addNewInventoryWidget extends StatefulWidget {
  addNewInventoryWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  static String route = "/addNewInventoryWidget";

  @override
  State<StatefulWidget> createState() => addNewInventoryState();
}

class addNewInventoryState extends State<addNewInventoryWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new Padding(
        padding: EdgeInsets.all(10),
        child: new SingleChildScrollView(
          child: Form(
            child: Column(children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(10),
                child: productCodeField(),
              ),
              new Padding(
                padding: EdgeInsets.all(10),
                child: barCodeField(),
              ),
              new Padding(
                padding: EdgeInsets.all(10),
                child: descriptionField(),
              ),
              new Padding(
                padding: EdgeInsets.all(10),
                child: addInventoryButton(pressedButton: submitButtonPressed),
              )
            ]),
            autovalidateMode: AutovalidateMode.always,
          ),
        ),
      ),
    );
  }

  void submitButtonPressed() {
    String description = descriptionFieldState.descriptionFieldController.text;
    String barCode = barCodeField.barCodeFieldController.text;
    String productCode = productCodeField.productCodeController.text;

    if (description == "" || barCode == "" || productCode == "") {
      _showAlertDialog();
    } else {
      Inventory inventory = new Inventory(
          barCode: barCode,
          productCode: productCode,
          description: description,
          importTime: DateTime.now());
      inventoryModule.addNewInventory(inventory, barCode);
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
            content: Text("Inventory info has been saved"),
            actions: [
              okAction,
            ],
          );
        });
  }
}
