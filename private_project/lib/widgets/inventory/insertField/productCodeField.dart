import 'package:flutter/material.dart';

class productCodeField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => productCodeFieldState();
}

class productCodeFieldState extends State<productCodeField> {
  static TextEditingController productCodeFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: productCodeFieldController,
      decoration: new InputDecoration.collapsed(
          hintText: "Product Code:", border: UnderlineInputBorder()),
    );
  }
}
