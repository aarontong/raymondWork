import 'package:flutter/material.dart';

class relatedPersonField extends StatefulWidget {
  static TextEditingController relatedPersonController =
      TextEditingController();

  @override
  State<StatefulWidget> createState() => relatedPersonState();
}

class relatedPersonState extends State<relatedPersonField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      decoration: new InputDecoration(
        hintText: "Related Person:",
        border: UnderlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: relatedPersonField.relatedPersonController.clear,
          icon: Icon(Icons.search),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: relatedPersonField.relatedPersonController,
    );
  }
}
