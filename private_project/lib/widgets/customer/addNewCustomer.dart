import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class addNewCustomerWidget extends StatelessWidget{
addNewCustomerWidget({Key? key, required this.title}) : super(key: key);
final String title;
static String route = "/addNewCustomerWidget";

@override
Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(body: Text('hello'),appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ));
}  
}