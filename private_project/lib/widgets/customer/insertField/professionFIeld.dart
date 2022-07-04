import 'package:flutter/material.dart';
class professionField extends StatelessWidget{
  static TextEditingController professionFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(decoration: new InputDecoration.collapsed(hintText: "Profession:",border: UnderlineInputBorder()),controller: professionFieldController);
  }

}