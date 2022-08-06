import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class descriptionField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => descriptionFieldState();
}

class descriptionFieldState extends State<descriptionField> {
  static TextEditingController descriptionFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      minLines: 10,
      maxLines: 15,
      controller: descriptionFieldController,
      decoration: new InputDecoration.collapsed(hintText: "ProductLine:"),
    );
  }
}
