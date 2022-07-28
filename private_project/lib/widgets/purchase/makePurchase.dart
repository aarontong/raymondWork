import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
