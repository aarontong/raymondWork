import 'package:flutter/material.dart';

class addCustomerButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(width: 100.0,height: 50.0, child: DecoratedBox(decoration: BoxDecoration(border: Border.all(
        color: Colors.red,
        width: 5,
      ),borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.red),child: TextButton(onPressed: (){
      print("Hello");
    }, child: Text("hello")),),);
  }

}