import 'package:flutter/material.dart';

import 'customerListPage.dart';

class searchPurchasedCustomer extends StatelessWidget {
  var title;
  static String route = "/searchPurchased";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: customerListPage(
        multipleSelection: false,
        purchasing: true,
      ),
    );
  }

  searchPurchasedCustomer({Key? key, required this.title}) : super(key: key);
}
