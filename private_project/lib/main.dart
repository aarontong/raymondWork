import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:private_project/model/customer.dart';
import 'package:private_project/widgets/customer/searchCustomerInfo.dart';
import 'package:private_project/widgets/inventory/addNewInventory.dart';
import 'package:private_project/widgets/inventory/searchInventory.dart';
import 'package:private_project/widgets/customer/searchRelatedPerson.dart';
import 'package:private_project/widgets/customer/searchPurchasedCustomer.dart';
import 'package:private_project/widgets/productCode/productListPage.dart';
import 'package:private_project/widgets/purchase/makePurchase.dart';
import 'widgets/customer/addNewCustomer.dart';
import 'widgets/customer/searchCustomer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await userCredentialsForGS.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        addNewCustomerWidget.route: (context) =>
            addNewCustomerWidget(title: "Add New Customer"),
        addNewInventoryWidget.route: (context) =>
            addNewInventoryWidget(title: "Add New Inventory"),
        searchCustomerInfo.route: (context) =>
            searchCustomerInfo(title: "Customer Info"),
        searchRelatedPerson.route: (context) =>
            searchRelatedPerson(title: "Related Customer"),
        searchPurchasedCustomer.route: (context) =>
            searchPurchasedCustomer(title: "Purchased Customer"),
        productListPage.route: (context) => productListPage(
              title: "Product Code List",
            ),
        makePurchaseWidget.route: (context) =>
            makePurchaseWidget(title: "Make Purchase"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  int counter = 0;
  List<Widget> tabs = [
    searchCustomerWidget(title: "Search Customer"),
    searchInventoryWidget(title: "Search Inventory"),
    makePurchaseWidget(title: "Make Purchase"),
  ];
  void setPage(int index) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (this.counter == 2 &&
          makePurchaseState.purchaseInventoryList.length > 0) {
        showClearPurchaseAlert();
      } else {
        this.counter = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Customer newCustomer = Customer();
    customerModule cm = customerModule.searchCustomer();
    cm.currentSelectedCustomer = newCustomer;
    return Scaffold(
      body: tabs[counter],
      bottomNavigationBar: BottomNavigationBar(
        key: globalKey,
        iconSize: 20,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Customer'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inventory'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/purchase-icon.png'),
              label: 'Purchase'),
        ],
        currentIndex: counter,
        onTap: (int index) {
          setPage(index);
        },
      ),
    );
  }

  static changeTab() {
    BottomNavigationBar navigationBar =
        globalKey.currentWidget as BottomNavigationBar;
    navigationBar.onTap!(0);
  }

  Future<void> showClearPurchaseAlert() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Widget yesButton = TextButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop();
              makePurchaseState.purchaseInventoryList.clear();
              MyHomePageState.changeTab();
            },
          );
          Widget noButton = TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop(); // dismiss dialog
            },
          );
          return AlertDialog(
            title: Text(""),
            content: Text("Clear current purchase cart?"),
            actions: [
              yesButton,
              noButton,
            ],
          );
        });
  }

  static showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
