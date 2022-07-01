import 'package:flutter/material.dart';

class emailField extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(validator: (value) => validateEmail(value),decoration: new InputDecoration.collapsed(hintText: "Email:",border: UnderlineInputBorder()) ,);
  }
String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return "";
  }
}