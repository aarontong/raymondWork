import 'package:flutter/material.dart';

class emailField extends StatelessWidget{
  static TextEditingController emailFieldController = TextEditingController();
  static bool emailValid = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(validator: (value) => validateEmail(value),decoration: new InputDecoration.collapsed(hintText: "Email:",border: UnderlineInputBorder()) , keyboardType: TextInputType.emailAddress,controller: emailFieldController);
  }
String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)){
      emailValid = false;
      return 'Enter a valid email address';
    }else{
      emailValid = true;
      return "";
    }
  }
}