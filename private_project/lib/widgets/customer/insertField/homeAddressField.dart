import 'package:flutter/material.dart';

class homeAddressField extends StatelessWidget{
  static TextEditingController homeAddressFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(decoration: new InputDecoration.collapsed(hintText: "Address:",border: UnderlineInputBorder()),keyboardType: TextInputType.streetAddress,controller: homeAddressFieldController);
  }

}