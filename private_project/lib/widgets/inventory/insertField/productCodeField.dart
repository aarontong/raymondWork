import 'package:flutter/material.dart';
import 'package:private_project/action/productModule.dart';
import 'package:private_project/widgets/productCode/productListPage.dart';

class productCodeField extends StatefulWidget {
  static TextEditingController productCodeController = TextEditingController();
  @override
  State<StatefulWidget> createState() => productCodeFieldState();
}

class productCodeFieldState extends State<productCodeField> {
  productModule pm = productModule();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future.delayed(Duration.zero, () {});
    return TextFormField(
      decoration: new InputDecoration(
        hintText: "Product Code:",
        border: UnderlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: pushToSearchPage,
          icon: Icon(Icons.search),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: productCodeField.productCodeController,
    );
  }

  void pushToSearchPage() {
    Navigator.pushNamed(context, productListPage.route).then((value) => null);
  }
}
