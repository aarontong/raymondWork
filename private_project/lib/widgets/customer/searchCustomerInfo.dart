import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';

import '../../model/customer.dart';

class searchCustomerInfo extends StatelessWidget {
  var title;

  searchCustomerInfo({Key? key, required this.title}) : super(key: key);

  static String route = "/customerInfo";
  @override
  Widget build(BuildContext context) {
    customerModule cm = customerModule.searchCustomer();
    Customer currentCustomer = cm.currentSelectedCustomer;
    String enName = currentCustomer.enName;
    String chName = currentCustomer.chName;
    String mobileNumber = currentCustomer.mobileNumber;
    String email = currentCustomer.email;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [Text("English Name:\t"), Text("$enName")],
              ),
              SizedBox(height: 10),
              Row(
                children: [Text("Chinese Name:\t"), Text("$chName")],
              ),
              SizedBox(height: 10),
              Row(
                children: [Text("Mobile:\t"), Text("$mobileNumber")],
              ),
              SizedBox(height: 10),
              Row(
                children: [Text("Email:\t"), Text("$email")],
              ),
              SizedBox(height: 10),
              Row(
                children: [Text("enName:\t"), Text("$enName")],
              ),
              SizedBox(height: 10),
              Row(
                children: [Text("enName:\t"), Text("$enName")],
              )
            ],
          )),
    );
  }
}
