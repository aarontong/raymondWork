import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
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
  static late int timestamp1;
  static String customerListJsonString = "";
  late addNewCustomerState state;
  late searchCustomerState state1;

  static final customerModule _customerModule = customerModule._internal();
  factory customerModule(addNewCustomerState state) {
    _customerModule.state = state;
    return _customerModule;
  }
  factory customerModule.searchCustomer(searchCustomerState state) {
    _customerModule.state1 = state;
    return _customerModule;
  }
  customerModule._internal();

  Future<void> addNewCustomer(Customer newCustomer, String mobileText) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Client");
    await addCustomerProfilePicture(newCustomer, mobileText);
    String enName = newCustomer.enName;
    String chName = newCustomer.chName;
    String age = newCustomer.age;
    String homeAddress = newCustomer.homeAddress;
    String email = newCustomer.email;
    String mobileNumber = newCustomer.mobileNumber;
    String profession = newCustomer.profession;
    String gender = newCustomer.gender;
    String profileImageURL = newCustomer.profileImageURL;

    ref = ref.child("\"$mobileText\"");
    await ref.set({
      "\"enName\"": "\"$enName\"",
      "\"chName\"": "\"$chName\"",
      "\"age\"": "\"$age\"",
      "\"address\"": "\"$homeAddress\"",
      "\"email\"": "\"$email\"",
      "\"mobile\"": "\"$mobileNumber\"",
      "\"profession\"": "\"$profession\"",
      "\"gender\"": "\"$gender\"",
      "\"profileImageURL\"": "\"$profileImageURL\""
    });
    updateCustomerListCache();
  }

  Future<void> updateCustomerListCache() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Client");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      customerListJsonString = snapshot.value.toString();
      String fileName = "customerListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      file.writeAsStringSync(snapshot.value.toString(),
          flush: true, mode: FileMode.write);
      DateTime nowDate = DateTime.now();
      timestamp1 = nowDate.millisecondsSinceEpoch;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("customerListCacheTime", timestamp1);
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  Future<String> getCachedContent() async {
    DateTime nowDate = DateTime.now();
    timestamp1 = nowDate.millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    int? cachedTime = prefs.getInt("customerListCacheTime");
    cachedTime = cachedTime != null ? cachedTime : 0;
    int difference = timestamp1 - cachedTime;
    if (difference < 5000 && !customerListJsonString.isEmpty) {
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
