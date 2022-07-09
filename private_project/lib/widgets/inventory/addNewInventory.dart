import 'package:flutter/material.dart';
import 'package:private_project/widgets/inventory/insertField/barCodeField.dart';
import 'package:private_project/widgets/inventory/insertField/descriptionFIeld.dart';
import 'package:private_project/widgets/inventory/insertField/productCodeField.dart';
import 'package:private_project/widgets/inventory/insertField/serialCodeField.dart';

class addNewInventoryWidget extends StatefulWidget {
  addNewInventoryWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  static String route = "/addNewInventoryWidget";

  @override
  State<StatefulWidget> createState() => addNewInventoryState();
}

class addNewInventoryState extends State<addNewInventoryWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new Padding(
        padding: EdgeInsets.all(10),
        child: new SingleChildScrollView(
          child: Form(
            child: Column(children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(10),
                child: productCodeField(),
              ),
              new Padding(
                padding: EdgeInsets.all(10),
                child: serialCodeField(),
              ),
              new Padding(
                padding: EdgeInsets.all(10),
                child: barCodeField(),
              ),
              new Padding(
                padding: EdgeInsets.all(10),
                child: descriptionField(),
              )
            ]),
            autovalidateMode: AutovalidateMode.always,
          ),
        ),
      ),
    );
  }
}
