import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class barCodeField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => productCodeFieldState();
}

class productCodeFieldState extends State<barCodeField> {
  static TextEditingController barCodeFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: barCodeFieldController,
      decoration: new InputDecoration.collapsed(
          hintText: "Bar Code:", border: UnderlineInputBorder()),
    );
  }
}
