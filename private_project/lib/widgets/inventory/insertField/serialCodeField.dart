import 'package:flutter/material.dart';

class serialCodeField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => serialCodeFieldState();
}

class serialCodeFieldState extends State<serialCodeField> {
  static TextEditingController barCodeFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: barCodeFieldController,
      decoration: new InputDecoration.collapsed(
          hintText: "Serial Code:", border: UnderlineInputBorder()),
    );
  }
}
