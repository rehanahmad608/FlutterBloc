import 'dart:io';

import 'package:demoapp/src/models/User.dart';
import 'package:demoapp/src/resources/UserProvider.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

class UserRepository {
  final userProvider = UserProvider();

  Future<String?> register(String phoneNum) => userProvider.register(phoneNum);
  Future<User?> signup(
          String fName, String lName, String phoneNum) =>
      userProvider.signup(fName, lName, phoneNum);
  Future<User?> verify(String userId, String code) =>
      userProvider.verifyUser(userId, code);
       Future<bool?> verifyNewUser(String userId, String code) =>
      userProvider.verifyNewUser(userId, code);
}
