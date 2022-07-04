import 'package:flutter/material.dart';

class ageField extends StatelessWidget{
  static TextEditingController ageFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(decoration: new InputDecoration.collapsed(hintText: "Age:",border: UnderlineInputBorder()),keyboardType: TextInputType.number,controller: ageFieldController,);
  }

}