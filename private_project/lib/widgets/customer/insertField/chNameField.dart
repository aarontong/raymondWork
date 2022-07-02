import 'package:flutter/material.dart';
class chNameField extends StatelessWidget{
  static TextEditingController chNameFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(decoration: new InputDecoration.collapsed(hintText: "Chinese Name:",border: UnderlineInputBorder()),keyboardType: TextInputType.name,);
  }

}