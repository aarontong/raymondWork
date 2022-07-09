import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/widgets/customer/insertField/addCustomerButton.dart';
import 'package:private_project/widgets/customer/insertField/ageField.dart';
import 'package:private_project/widgets/customer/insertField/chNameField.dart';
import 'package:private_project/widgets/customer/insertField/emailField.dart';
import 'package:private_project/widgets/customer/insertField/enNameFIeld.dart';
import 'package:private_project/widgets/customer/insertField/genderField.dart';
import 'package:private_project/widgets/customer/insertField/homeAddressField.dart';
import 'package:private_project/widgets/customer/insertField/mobileFIeld.dart';
import 'package:private_project/widgets/customer/insertField/nameCardImage.dart';
import 'package:private_project/widgets/customer/insertField/professionFIeld.dart';

class addNewCustomerWidget extends StatefulWidget{
addNewCustomerWidget({Key? key, required this.title}) : super(key: key);
final String title;
static String route = "/addNewCustomerWidget";

  @override
  State<StatefulWidget> createState() => addNewCustomerState();



}

class addNewCustomerState extends State<addNewCustomerWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(body: Padding(padding: EdgeInsets.all(10),child: SingleChildScrollView(child: Form(autovalidateMode: AutovalidateMode.always,
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
                              Padding(padding: EdgeInsets.all(10),child:addCustomerButton(pressedButton: submitButtonPressed,)),


                            ],
                          )))),
                        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ));
      
}
Future<void> _showAlertDialog() async {
  return showDialog(context: context, builder: (BuildContext context){
    Widget okAction = TextButton(
    child: Text("OK"),
    onPressed: () {       
      Navigator.of(context).pop(); // dismiss dialog
},
  );

    
    
     return AlertDialog(title: Text("Input Missing"), content: Text("Please enter data in all fields"), actions: [
      okAction,

    ],);});
}  
Future<void> submitButtonPressed() async {
  String emailText = emailField.emailFieldController.text;
  String mobileText = mobileField.mobileFieldController.text;
  String enNameText = enNameField.enNameFieldController.text;
  String chNameText = chNameField.chNameFieldController.text;
  String homeAddressText = homeAddressField.homeAddressFieldController.text;
  String ageText = ageField.ageFieldController.text;
  String professionFieldText = professionField.professionFieldController.text;
  if(emailText == "" || mobileText == "" || enNameText == "" || chNameText == "" ||
  homeAddressText == "" || ageText == "" || professionFieldText == ""){
    _showAlertDialog();
  }else{
    
    Customer newCustomer = new Customer(chName: chNameText, enName: enNameText, mobileNumber: mobileText, 
    email: emailText, age: ageText, gender: genderField.gender, 
    homeAddress: homeAddressText, profession: professionFieldText);
    customerModule.addNewCustomer(newCustomer,mobileText);




  }

}


}