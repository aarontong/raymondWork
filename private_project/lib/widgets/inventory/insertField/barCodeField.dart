import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:private_project/widgets/customer/insertField/relatedPersonField.dart';

class barCodeField extends StatefulWidget {
  static TextEditingController barCodeFieldController = TextEditingController();

  @override
  State<StatefulWidget> createState() => barCodeFieldState();
}

class barCodeFieldState extends State<barCodeField> {
  String barCodeString = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: barCodeField.barCodeFieldController,
      decoration: new InputDecoration.collapsed(
          hintText: "Bar Code:", border: UnderlineInputBorder()),
      onTap: scanBarCode,
    );

    /*
    TextFormField(
      controller: barCodeFieldController,
      decoration: new InputDecoration.collapsed(
          hintText: "Bar Code:", border: UnderlineInputBorder()),
      onTap: scanBarCode,
    );
    */
    /*
    TextFormField(
        decoration: new InputDecoration(
          hintText: "Related Person:",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: pushToSearchPage,
            icon: Icon(Icons.search),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        controller: relatedPersonField.relatedPersonController,
      );
      */
  }

  Future<void> scanBarCode() async {
    setState(() async {
      barCodeField.barCodeFieldController.text =
          await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    });
  }
}
