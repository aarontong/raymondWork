import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/action/pdfModule.dart';
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';
import 'package:private_project/widgets/customer/insertField/relatedPersonField.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';
import 'package:private_project/widgets/productCode/purchasedCustomerField.dart';
import 'package:private_project/widgets/purchase/makePurchaseButton.dart';
import 'package:provider/provider.dart';

class makePurchaseWidget extends StatefulWidget {
  static String route = "/makePurchaseWidget";
  makePurchaseWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => makePurchaseState();
}

class makePurchaseState extends State<makePurchaseWidget> {
  customerModule cm = customerModule.searchCustomer();
  pdfModule pm = pdfModule();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    pm.initDocument();
    // TODO: implement build
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
                          padding: EdgeInsets.all(10), child: barCodeField()),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: purchasedCustomerField()),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: makePurchaseButton(
                            pressedButton: submitButtonPressed,
                          ))
                    ])))));
  }

  Future<void> submitButtonPressed() async {
    String barcodeText = barCodeField.barCodeFieldController.text;

    if (barcodeText == "") {
      _showAlertDialog();
    } else {
      Inventory? editInventory =
          await userCredentialsForGS.searchInventoryCell(barcodeText);
      if (editInventory != null) {
        editInventory.purchaseCustomer =
            cm.currentSelectedCustomer.mobileNumber;
        editInventory.soldTimeString = DateTime.now().toString();

        await userCredentialsForGS.insertInventory(editInventory);
        _showSuccessDialog();
        barCodeField.barCodeFieldController.text = "";
      } else {
        _showBarcodeInvalidAlert();
      }
    }
  }

  Future<void> _showBarcodeInvalidAlert() async {
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
            title: Text("Error"),
            content: Text("Bar code is not in inventory list"),
            actions: [
              okAction,
            ],
          );
        });
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
              Navigator.of(context).pop(); // dismiss dialog
            },
          );

          return AlertDialog(
            title: Text("Input Success"),
            content: Text("Purchase record can be saved now. Thanks!"),
            actions: [
              okAction,
            ],
          );
        });
  }
}
