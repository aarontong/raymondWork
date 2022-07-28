import 'package:flutter/material.dart';

class searchProductWidget extends StatefulWidget {
  const searchProductWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<searchProductWidget> createState() => searchProductState(title: title);
}

class searchProductState extends State<searchProductWidget> {
  searchProductState({Key? key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(title)),
    );
  }
}
