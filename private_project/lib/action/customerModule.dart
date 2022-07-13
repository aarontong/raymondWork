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

import '../model/customer.dart';

class customerModule {
  static String customerListJsonString = "";
  late addNewCustomerState state;
  static final customerModule _customerModule = customerModule._internal();
  factory customerModule(addNewCustomerState state) {
    _customerModule.state = state;
    return _customerModule;
  }

  customerModule._internal();

  Future<void> addNewCustomer(Customer newCustomer, String mobileText) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Client");
    await addCustomerProfilePicture(newCustomer, mobileText);
    ref = ref.child(mobileText);
    await ref.set({
      "enName": newCustomer.enName,
      "chName": newCustomer.chName,
      "age": newCustomer.age,
      "address": {"line1": newCustomer.homeAddress},
      "email": newCustomer.email,
      "mobile": newCustomer.mobileNumber,
      "profession": newCustomer.profession,
      "gender": newCustomer.gender,
      "profileImageURL": newCustomer.profileImageURL
    });
    updateCustomerListCache();
  }

  void updateCustomerListCache() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Client");
    ref.onValue.listen((event) async {
      final data = event.snapshot.value;
      String dataString = data.toString();
      String fileName = "customerListCache.json";
      var dir = await getTemporaryDirectory();
      File file = File(dir.path + "/" + fileName);
      file.writeAsStringSync(dataString, flush: true, mode: FileMode.write);
      getCachedContent();
    });
  }

  Future<void> getCachedContent() async {
    String fileName = "customerListCache.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    customerListJsonString = await file.readAsString();
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
