import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/widgets/customer/searchPurchasedCustomer.dart';
import 'package:provider/provider.dart';

class purchasedCustomerField extends StatefulWidget {
  static String purchasedCustomerString = "";
  static TextEditingController purchasedCustomerController =
      TextEditingController();

  @override
  State<StatefulWidget> createState() => purchasedCustomerState();
}

class purchasedCustomerState extends State<purchasedCustomerField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    customerModule cm = customerModule.searchCustomer();
    purchasedCustomerField.purchasedCustomerController.text =
        cm.currentSelectedCustomer.enName;

    return TextFormField(
      decoration: new InputDecoration(
        hintText: "Purchased Customer:",
        border: UnderlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: pushToSearchPage,
          icon: Icon(Icons.search),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: purchasedCustomerField.purchasedCustomerController,
    );
  }

  void pushToSearchPage() {
    setState(() {
      //customerModule cm = customerModule.searchCustomer();
      // cm.currentSelectedCustomer.relatedPerson = [];
      purchasedCustomerField.purchasedCustomerString = "";
    });
    Navigator.pushNamed(context, searchPurchasedCustomer.route);
  }
}
