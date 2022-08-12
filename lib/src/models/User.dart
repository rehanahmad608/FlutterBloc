import 'package:flutter/cupertino.dart';

class User {
   String userId="";
  String firstName ="";
  String lastName="";
  String mobileNo="";
  String email="";

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
  });

  User.fromJson(Map<String, dynamic> json) {
    this.userId = json['id'];
    this.firstName = json['firstName'];
    this.lastName = json['lastName'];
    this.mobileNo = json['mobileNo'];
    this.email = json['email'] ?? '';
  }

  String get getUserid => this.userId;
  String get getFirstName => this.firstName;
  String get getLastName => this.lastName;
  String get getEmail => this.email;
  String get getmobileNum => this.mobileNo;
}
