import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';

class markPurchase extends StatelessWidget {
  const markPurchase({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: new Padding(
          padding: EdgeInsets.all(10),
          child: new Form(
              child: Column(children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(10),
              child: barCodeField(),
            )
          ]))),
    );
  }
}
