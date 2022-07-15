import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:private_project/action/customerModule.dart';
import 'package:tableview/tableview.dart';
import 'package:private_project/widgets/customer/addNewCustomer.dart';

class searchCustomerWidget extends StatefulWidget {
  const searchCustomerWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  static String route = "/searchCustomerWidget";

  @override
  State<searchCustomerWidget> createState() =>
      searchCustomerState(title: title);
}

class searchCustomerState extends State<searchCustomerWidget> {
  static List<List<String>> rowList = [
    ["阿昌族"],
    ["白族", "保安族", "布朗族", "布依族"],
    ["藏族", "朝鲜族"],
    ["傣族", "达斡尔族", "德昂族", "东乡族", "侗族", "独龙族"],
    ["鄂伦春族", "俄罗斯族", "鄂温克族"],
    ["高山族", "仡佬族"],
    ["哈尼族", "汉族", "哈萨克族", "赫哲族", "回族"],
    ["景颇族", "京族", "基诺族"],
    ["柯尔克孜族"],
    ["拉祜族", "傈僳族", "黎族", "珞巴族"],
    ["满族", "毛南族", "门巴族", "蒙古族", "苗族", "仫佬族"],
    ["纳西族", "怒族"],
    ["普米族"],
    ["羌族"],
    ["撒拉族", "畲族", "水族"],
    ["塔吉克族", "塔塔尔族", "土家族", "土族"],
    ["佤族", "维吾尔族", "乌孜别克族"],
    ["锡伯族"],
    ["瑶族", "彝族", "裕固族"],
  ];
  static List<String> headerList = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "G",
    "H",
    "J",
    "K",
    "L",
    "M",
    "N",
    "P",
    "Q",
    "S",
    "T",
    "W",
    "X",
    "Y",
    "Z"
  ];

  final String title;
  searchCustomerState({Key? key, required this.title});
  var delegate = TableViewDelegate(numberOfSectionsInTableView: () {
    return 1;
  }, numberOfRowsInSection: (int section) {
    return rowList[section].length;
  }, heightForHeaderInSection: (int section) {
    return 20;
  }, heightForRowAtIndexPath: (IndexPath indexPath) {
    return 40;
  }, viewForHeaderInSection: (BuildContext context, int section) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      color: Color.fromRGBO(220, 220, 220, 1),
      height: 20,
      child: Text(headerList[section]),
    );
  }, cellForRowAtIndexPath: (BuildContext context, IndexPath indexPath) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(rowList[indexPath.section][indexPath.row]);
      },
      child: Container(
        color: Colors.white,
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  rowList[indexPath.section][indexPath.row],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              height: 1,
            ),
          ],
        ),
      ),
    );
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    customerModule cm = customerModule.searchCustomer(this);
    return Scaffold(
      body: FutureBuilder<String>(
        future: cm.getCachedContent(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // data loaded:
            final androidDeviceInfo = snapshot.data;
            return Center(
              child: TableView(
                delegate: delegate,
                scrollbar: TableViewHeaderScrollBar(
                  headerTitleList: headerList,
                  itemHeight: 20,
                  startAlignment: Alignment.centerRight,
                ),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, addNewCustomerWidget.route);
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
