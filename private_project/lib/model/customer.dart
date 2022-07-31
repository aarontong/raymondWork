import 'dart:io';

import 'package:flutter/material.dart';
import 'package:private_project/action/customerModule.dart';

class Customer extends ChangeNotifier {
  late String chName;
  late String enName;
  late String mobileNumber;
  late String email;
  late String profession;
  late String gender;
  late String address;
  late String age;
  late File profileImage;
  late String profileImageURL;
  late String relatedPersonString;
  late List<Customer> relatedPerson = [];
  Customer({Key? key});

  Customer.fromJson(Map<String, dynamic> json)
      : chName = json["chName"],
        enName = json["enName"],
        mobileNumber = json["mobileNumber"],
        email = json["email"],
        age = json["age"],
        gender = json["gender"],
        address = json["address"],
        profession = json["profession"],
        profileImageURL = json["profileImageURL"],
        relatedPersonString = json["relatedPersonString"];

  Map<String, dynamic> toJson() => {
        customerModule.enName: enName,
        customerModule.chName: chName,
        customerModule.age: age,
        customerModule.enName: enName,
        customerModule.address: address,
        customerModule.email: email,
        customerModule.mobileNumber: mobileNumber,
        customerModule.profession: profession,
        customerModule.gender: gender,
        customerModule.profileImageURL: profileImageURL,
        customerModule.relatedPersonString: relatedPersonString,
      };
  void addRelatedPeople(Customer customer) {
    this.relatedPerson.add(customer);
    notifyListeners();
  }

  void removeRelatedPeople(Customer customer) {
    this.relatedPerson.remove(customer);
    notifyListeners();
  }
}
