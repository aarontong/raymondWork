import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:private_project/credentials/userCredentialsForGS.dart';
import 'package:private_project/widgets/customer/addNewCustomer.dart';
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
import 'package:private_project/widgets/customer/searchCustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/customer.dart';

class customerModule {
  static String enName = "enName";
  static String chName = "chName";
  static String age = "age";
  static String address = "address";
  static String email = "email";
  static String mobileNumber = "mobileNumber";
  static String profession = "profession";
  static String gender = "gender";
  static String profileImageURL = "profileImageURL";
  static String relatedPersonString = "relatedPersonString";

  late Customer currentSelectedCustomer;

  static late int timestamp1;
  static String customerListJsonString = "";
  late addNewCustomerState state;

  static final customerModule _customerModule = customerModule._internal();
  factory customerModule(addNewCustomerState state) {
    _customerModule.state = state;
    return _customerModule;
  }
  factory customerModule.searchCustomer() {
    return _customerModule;
  }
  customerModule._internal();

  static List<String> getWorksheetTitle() => [
        enName,
        chName,
        age,
        address,
        email,
        mobileNumber,
        profession,
        gender,
        profileImageURL,
        relatedPersonString
      ];
  Future<void> addNewCustomer(Customer newCustomer) async {
    await addCustomerProfilePicture(newCustomer, newCustomer.mobileNumber);

    await userCredentialsForGS.insertUser([newCustomer.toJson()]);
    await updateCustomerListCache();
  }

  Future<void> updateCustomerListCache() async {
    String customerListJsonString = await userCredentialsForGS.getAllUser();
    String fileName = "customerListCache.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    file.writeAsStringSync(customerListJsonString,
        flush: true, mode: FileMode.write);
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("customerListCacheTime", timestamp1);
    String snapString = customerListJsonString;
  }

  Future<String> getCachedContent() async {
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    int? cachedTime = prefs.getInt("customerListCacheTime");
    cachedTime = cachedTime != null ? cachedTime : 0;
    int difference = timestamp1 - cachedTime;
    if (difference < 300000) {
      String fileName = "customerListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      customerListJsonString = await file.readAsString();
    } else {
      await updateCustomerListCache();
    }
    return customerListJsonString;
  }

  Future<void> addCustomerProfilePicture(
      Customer newCustomer, String mobileText) async {
    final storageRef = FirebaseStorage.instance.ref();

    Reference? imageRef =
        storageRef.child("customer-profile-image/" + mobileText);
    try {
      UploadTask task = imageRef.putFile(newCustomer.profileImage);
      var imageUrl = await (await task).ref.getDownloadURL();
      String url = imageUrl.toString();
      newCustomer.profileImageURL = url;
      await task.whenComplete(() => null);
    } on FirebaseException catch (error) {
      if (error != null) {
        print(error);
        return;
      }
    }
  }
}
