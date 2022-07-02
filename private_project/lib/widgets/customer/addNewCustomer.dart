import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:private_project/widgets/customer/insertField/ageField.dart';
import 'package:private_project/widgets/customer/insertField/chNameField.dart';
import 'package:private_project/widgets/customer/insertField/emailField.dart';
import 'package:private_project/widgets/customer/insertField/enNameFIeld.dart';
import 'package:private_project/widgets/customer/insertField/genderField.dart';
import 'package:private_project/widgets/customer/insertField/homeAddressField.dart';
import 'package:private_project/widgets/customer/insertField/mobileFIeld.dart';
import 'package:private_project/widgets/customer/insertField/nameCardImage.dart';
import 'package:private_project/widgets/customer/insertField/professionFIeld.dart';

class addNewCustomerWidget extends StatelessWidget{
addNewCustomerWidget({Key? key, required this.title}) : super(key: key);
final String title;
static String route = "/addNewCustomerWidget";

@override
Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(body: Padding(padding: EdgeInsets.all(10),child: Form(autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10),child:enNameField()),
                              Padding(padding: EdgeInsets.all(10),child:chNameField()),
                              Padding(padding: EdgeInsets.all(10),child:ageField()),
                              Padding(padding: EdgeInsets.all(10),child:emailField()),
                              Padding(padding: EdgeInsets.all(10),child:mobileField()),
                              Padding(padding: EdgeInsets.all(10),child:professionField()),
                              Padding(padding: EdgeInsets.all(10),child:homeAddressField()),
                              Padding(padding: EdgeInsets.all(10),child:genderField()),
                              Padding(padding: EdgeInsets.all(10),child:nameCardImageField()),


                            ],
                          ))),
                        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ));
}  
}