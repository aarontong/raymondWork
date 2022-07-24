import 'dart:io';

import 'package:flutter/material.dart';

class Customer extends ChangeNotifier {
  late String chName;
  late String enName;
  late String mobileNumber;
  late String email;
  late String profession;
  late String gender;
  late String homeAddress;
  late String age;
  late File profileImage;
  late String profileImageURL;
  late String relatedPersonString;
  late List<Customer> relatedPerson = [];
  Customer({Key? key});

  Customer.fromJson(Map<String, dynamic> json)
      : chName = json["chName"],
        enName = json["enName"],
        mobileNumber = json["mobile"],
        email = json["email"],
        age = json["age"],
        gender = json["gender"],
        homeAddress = json["address"],
        profession = json["profession"],
        profileImageURL = json["profileImageURL"],
        relatedPersonString = json["relatedPerson"];

  Map<String, dynamic> toJson() => {
        "chName": chName,
        "enName": enName,
        "mobile": mobileNumber,
        "email": email,
        "age": age,
        "gender": gender,
        "address": homeAddress,
        "profession": profession,
        "profileImageURL": profileImageURL,
        "relatedPersonString": relatedPersonString
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
