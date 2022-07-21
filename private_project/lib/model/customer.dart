import 'dart:io';

import 'package:flutter/material.dart';

class Customer {
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
  late List<Customer> relatedPerson = [];
  Customer(
      {Key? key,
      required this.chName,
      required this.enName,
      required this.mobileNumber,
      required this.email,
      required this.age,
      required this.gender,
      required this.homeAddress,
      required this.profession,
      required this.profileImage});

  Customer.fromJson(Map<String, dynamic> json)
      : chName = json['chName'],
        enName = json['enName'],
        mobileNumber = json['mobile'],
        email = json['email'],
        age = json['age'],
        gender = json['gender'],
        homeAddress = json['address'],
        profession = json['profession'],
        profileImageURL = json['profileImageURL'];

  Map<String, dynamic> toJson() => {
        'chName': chName,
        'enName': enName,
        'mobile': mobileNumber,
        'email': email,
        'age': age,
        'gender': gender,
        'address': homeAddress,
        'profession': profession,
        'profileImageURL': profileImageURL,
      };
}
