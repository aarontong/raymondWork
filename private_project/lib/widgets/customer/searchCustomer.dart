import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:private_project/widgets/customer/addNewCustomer.dart';
class searchCustomerWidget extends StatefulWidget{
  const searchCustomerWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  static String route = "/searchCustomerWidget";

  @override
  State<searchCustomerWidget> createState() => searchCustomerState(title: title);

}

class searchCustomerState extends State<searchCustomerWidget>{
  final String title;
  searchCustomerState({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Text('hello'),appBar: AppBar(title: Text(this.title),actions: [IconButton(onPressed: (){
      Navigator.pushNamed(context, addNewCustomerWidget.route);
    }, icon: Icon(Icons.add))],),);
  }

}