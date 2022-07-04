import 'package:flutter/material.dart';
class enNameField extends StatelessWidget{
  static TextEditingController enNameFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(decoration: new InputDecoration.collapsed(hintText: "English Name:",border: UnderlineInputBorder()),keyboardType: TextInputType.name,controller: enNameFieldController);
  }

}