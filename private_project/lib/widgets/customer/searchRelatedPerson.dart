import 'package:flutter/material.dart';

import 'customerListPage.dart';

class searchRelatedPerson extends StatelessWidget {
  var title;
  static String route = "/searchRelatedPerson";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: customerListPage(
        multipleSelection: true,
        purchasing: false,
      ),
    );
  }

  searchRelatedPerson({Key? key, required this.title}) : super(key: key);
}
