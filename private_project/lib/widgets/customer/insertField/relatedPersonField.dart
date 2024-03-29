import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/widgets/customer/searchRelatedPerson.dart';
import 'package:provider/provider.dart';

class relatedPersonField extends StatefulWidget {
  static String relatedPersonString = "";
  static TextEditingController relatedPersonController =
      TextEditingController();

  @override
  State<StatefulWidget> createState() => relatedPersonState();
}

class relatedPersonState extends State<relatedPersonField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    customerModule cm = customerModule.searchCustomer();

    return Consumer<Customer>(builder: (context, model, child) {
      for (Customer c in model.relatedPerson) {
        String name = c.enName;
        String phone = c.mobileNumber;
        relatedPersonField.relatedPersonString += "$name\t$phone ,";
      }
      Future.delayed(Duration.zero, () {
        relatedPersonField.relatedPersonController.text =
            relatedPersonField.relatedPersonString;
      });
      return TextFormField(
        decoration: new InputDecoration(
          hintText: "Related Person:",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: pushToSearchPage,
            icon: Icon(Icons.search),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        controller: relatedPersonField.relatedPersonController,
      );
    });
  }

  void pushToSearchPage() {
    setState(() {
      customerModule cm = customerModule.searchCustomer();
      cm.currentSelectedCustomer.relatedPerson = [];
      relatedPersonField.relatedPersonString = "";
    });
    Navigator.pushNamed(context, searchRelatedPerson.route);
  }
}
