import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:private_project/widgets/purchase/addItemButton.dart';
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
  static List<Inventory> purchaseInventoryList = [];
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  customerModule cm = customerModule.searchCustomer();
  pdfModule pm = pdfModule();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    pm.initDocument();
    var purchasedListWidget = SingleChildScrollView(
      child: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            String barCode = purchaseInventoryList[index].barCode;
            String productCode = purchaseInventoryList[index].productCode;

            return Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Bar Code: $barCode",
                        maxLines: 2,
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        "Product Code: $productCode",
                        maxLines: 2,
                      ),
                      flex: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          deleteItem(index);
                        },
                        child: Text("Delete Item")),
                  ],
                ));
          },
          itemCount: purchaseInventoryList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        ),
      ),
    );

    // TODO: implement build
    bool itemInList = purchaseInventoryList.length > 0;
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
                      purchasedListWidget,
                      itemInList
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: SizedBox(
                                width: 150.0,
                                height: 50.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 5,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white),
                                  child: TextButton(
                                      onPressed: () {
                                        confirmPurchase(purchaseInventoryList);
                                      },
                                      child: Text("confirm purchase")),
                                ),
                              ))
                          : SizedBox(),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: addItemButton(
                            pressedButton: addItemButtonPressed,
                          ))
                    ])))));
  }

  void deleteItem(int index) {
    setState(() {
      purchaseInventoryList.remove(purchaseInventoryList[index]);
    });
  }

  Future<void> confirmPurchase(List<Inventory> inventoryList) async {
    customerModule cm = customerModule.searchCustomer();
    DateTime now = DateTime.now();
    Purchase newPurchase = new Purchase(
        purchasedInventory: inventoryList,
        customerName: cm.currentSelectedCustomer.enName,
        customerPhone: cm.currentSelectedCustomer.mobileNumber,
        soldTime: DateFormat('dd/MM/yyyy HH:mm:ss').format(now),
        receiptID: "1000");
    MyHomePageState.showLoadingDialog(context);
    try {
      await userCredentialsForGS.insertPurchase(newPurchase);
      Navigator.pop(context);
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog();
    }
  }

  Future<void> addItemButtonPressed() async {
    String barcodeText = barCodeField.barCodeFieldController.text;

    if (barcodeText == "") {
      _showAlertDialog();
    } else {
      Inventory? editInventory =
          await userCredentialsForGS.searchInventoryCell(barcodeText);
      if (editInventory != null) {
        setState(() {
          purchaseInventoryList.add(editInventory);
          barCodeField.barCodeFieldController.text = "";
        });
        pm.initDocument();
      } else {
        _showBarcodeInvalidAlert();
      }
    }
  }

  Future<void> _showSuccessDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Widget okAction = TextButton(
            child: Text("OK"),
            onPressed: () async {
              Directory tempDir = await getTemporaryDirectory();
              String pdfStoragePath = tempDir.path;
              File tempFile = File('$pdfStoragePath/copy.pdf');
              pm.printDocument(tempFile);
              //   pm.sendEmail();
              barCodeField.barCodeFieldController.text = "";
              purchasedCustomerField.purchasedCustomerController.text = "";
              Navigator.pop(context);
            },
          );

          return AlertDialog(
            title: Text("Input Success"),
            content: Text("Purchase record has been saved"),
            actions: [
              okAction,
            ],
          );
        });
  }

  Future<void> _showErrorDialog() async {
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
            title: Text("Error"),
            content: Text("Failed to Purchase Record"),
            actions: [
              okAction,
            ],
          );
        });
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
