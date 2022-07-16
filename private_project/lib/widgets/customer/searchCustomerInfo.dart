import 'package:flutter/material.dart';

class searchCustomerInfo extends StatelessWidget {
  var title;

  searchCustomerInfo({Key? key, required this.title}) : super(key: key);

  static String route = "/customerInfo";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Text('hello'),
    );
  }
}
