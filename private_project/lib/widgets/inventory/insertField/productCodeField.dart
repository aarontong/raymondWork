import 'package:flutter/material.dart';

class productCodeField extends StatefulWidget {
  static TextEditingController productCodeController = TextEditingController();
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
      decoration: new InputDecoration(
        hintText: "Product Code:",
        border: UnderlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: productCodeField.productCodeController.clear,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
