import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class barCodeField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => barCodeFieldState();
}

class barCodeFieldState extends State<barCodeField> {
  String barCodeString = "";
  static TextEditingController barCodeFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: barCodeFieldController,
      decoration: new InputDecoration.collapsed(
          hintText: "Bar Code:", border: UnderlineInputBorder()),
      onTap: scanBarCode,
    );
  }

  Future<void> scanBarCode() async {
    setState(() async {
      barCodeFieldController.text = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    });
  }
}
