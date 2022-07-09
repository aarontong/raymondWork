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
}
