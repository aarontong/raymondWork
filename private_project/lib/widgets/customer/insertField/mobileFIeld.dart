import 'package:flutter/material.dart';

class mobileField extends StatelessWidget{
  static TextEditingController mobileFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(decoration: new InputDecoration.collapsed(hintText: "Mobile Phone:",border: UnderlineInputBorder()),keyboardType: TextInputType.phone,controller: mobileFieldController);
  }

}