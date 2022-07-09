import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
  late addNewCustomerState state;
  static final customerModule _customerModule = customerModule._internal();
  factory customerModule.single(addNewCustomerState state) {
    customerModule(state);
    return _customerModule;
  }
  customerModule(addNewCustomerState state) {
    this.state = state;
  }

  customerModule._internal();

  static Future<void> addNewCustomer(
      Customer newCustomer, String mobileText) async {
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
  }

  static Future<void> addCustomerProfilePicture(
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
