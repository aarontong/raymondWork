import 'package:flutter/material.dart';
import 'package:private_project/widgets/inventory/addNewInventory.dart';

class searchInventoryWidget extends StatefulWidget{
  const searchInventoryWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<searchInventoryWidget> createState() => searchInventoryState(title: title);

}

class searchInventoryState extends State<searchInventoryWidget>{
  searchInventoryState({Key? key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text(title),actions: [IconButton(onPressed: (){
      Navigator.pushNamed(context, addNewInventoryWidget.route);
    }, icon: Icon(Icons.add))]));
  }

}