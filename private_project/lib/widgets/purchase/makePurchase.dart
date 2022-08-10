import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/action/pdfModule.dart';
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:private_project/main.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/model/inventory.dart';
import 'package:private_project/model/purchase.dart';
import 'package:private_project/widgets/customer/insertField/relatedPersonField.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';
import 'package:private_project/widgets/productCode/purchasedCustomerField.dart';
import 'package:private_project/widgets/purchase/makePurchaseButton.dart';
import 'package:private_project/widgets/purchase/purchaseConfirmDialog.dart';
import 'package:provider/provider.dart';

class makePurchaseWidget extends StatefulWidget {
  static String route = "/makePurchaseWidget";
  makePurchaseWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => makePurchaseState();
}

class makePurchaseState extends State<makePurchaseWidget> {
  static bool purchaseConfirmed = false;
  static List<Inventory> purchaseInventoryList = [];
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  customerModule cm = customerModule.searchCustomer();
  pdfModule pm = pdfModule();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    pm.initDocument();
    var purchasedListWidget = SingleChildScrollView(child: Center(child: 
                              Column(//crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:<Widget>[
                              ListView.builder(itemBuilder: (BuildContext context, index) => 
                                                Padding(padding: EdgeInsets.all(10), 
                                                child:Row(children: <Widget>[
                                                  Expanded(child: Text("hello"),flex: 1,),
                                                  Expanded(child: Text("there"),flex: 1,),
                                                ],)),
                                                itemCount: purchaseInventoryList.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                              ),
                              SizedBox(
                                    width: 150.0,
                                    height: 50.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 5,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: Colors.white),
                                      child: TextButton(
                                          onPressed: () {
                                          
                                          },
                                          child: Text("confirm purchase")),
                                    ),
                                  )],)),);  

    // TODO: implement build
    return new Scaffold(
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
                      purchaseConfirmed? purchasedListWidget:
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
        purchaseInventoryList.add(editInventory);
        //editInventory.customer = cm.currentSelectedCustomer.mobileNumber;
        // editInventory.soldTimeString = DateTime.now().toString();

        //   await userCredentialsForGS.insertInventory(editInventory);
        pm.initDocument();
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
          Widget dismissAction = TextButton(
            child: Text("Dismiss"),
            onPressed: () {
              Navigator.of(context).pop(); 
              setState(() {
                purchaseConfirmed = true;
              });
            },
          );
          Widget continueShoppintAction = TextButton(
            child: Text("Continue Shopping"),
            onPressed: () {},
          );
          return AlertDialog(
            title: Text("Input Success"),
            content: Text("Purchase record can be saved now. Thanks!"),
            actions: [
              continueShoppintAction,
              dismissAction,
            ],
          );
        });
  }
/*
  void showPurchaseItemListDialog() {
    DialogWidget alert = DialogWidget.alert(
      closable: true,
      style: DialogStyle.material,
      title: "Title",
      content: "Content",
      actions: [
        DialogAction(
          title: "Button One",
          handler: null,
          isDestructive: true,
        ),
        DialogAction(
          title: "Button Two",
          handler: null,
          isDefault: true,
        ),
      ],
    );
    DialogHelper().show(
      context,
      alert,
    );
  }
  */
}
