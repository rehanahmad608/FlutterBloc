import 'dart:convert';
import 'dart:io';

import 'package:demoapp/src/models/User.dart';
import 'package:http/http.dart' as http;

final serverUrl = 'https://api.loade.app/v1/';

class UserProvider {
   String? globalOtp;
  final baseServer = serverUrl + 'Customer/';

  final userbaseServer = serverUrl + 'User/';

  final headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Future<User> getUser(String userId) async {
    try {
      final url = Uri.parse(baseServer + 'getbyid?id=$userId');
      print(url);
      final response = await http.get(url, headers: headers);
      print(response.toString());
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody['status_code'] == 200)
        return User.fromJson(responseBody['data']);
      else {
        throw responseBody['data']['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String?> register(String phoneNum) async {
    try {
      final url = Uri.parse(userbaseServer + 'signup-signin');
      final body = jsonEncode({
        "mobileNo": phoneNum,
        "udId": "",
        "notification": {"title": "Register", "body": "User Register"}
      });
      print(body);
      final response = await http.post(url, body: body, headers: headers);
      print(response.toString());

      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody['status_code'] == 200) {
         globalOtp = responseBody['data']['code'];
        return responseBody['data']['id'];
      } else {
        throw responseBody['data']['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> signup(String fName, String lName, String phoneNum) async {
    try {
      final url = Uri.parse(baseServer + 'signup');
      final body = jsonEncode({
        "firstName": fName,
        "lastName": lName,
        "city": null,
        "image": null,
        "language": null,
        "mobileNo": phoneNum,
        "udId": null,
        "notification": {"text": "Sign Up", "body": "Welcome To Loade"},
      });
      final response = await http.post(url, body: body, headers: headers);
      print(response.toString());
      final responseBody = jsonDecode(response.body);
      print(responseBody);  
      if (responseBody['status_code'] == 200)
        return User.fromJson(responseBody['data']);
      else {
        throw responseBody['message'];
      }
    } catch (e) {
      throw e.toString();
    }
    
  }
  
  Future<User?> verifyUser(String userId, String code) async {
   
    try {
      final url = Uri.parse(baseServer + 'verify');
      // final body = jsonEncode({'userId': userId, 'code': code});
      final body = jsonEncode({
        'userIdOrMobileNo': userId,
        'code': globalOtp,
        // 'code': code,
        'language': "English",
      });
      print(body);
      final response = await http.post(url, body: body, headers: headers);
      print(response.toString());
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody['status_code'] == 200)
        return User.fromJson(responseBody['data']);
      else {
        // Actual response
        throw responseBody['data']['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool?> verifyNewUser(String userId, String code) async {
 
    try {
      final url = Uri.parse(userbaseServer + 'verify');

      final body = jsonEncode({
        'userIdOrMobileNo': userId,
        'code': globalOtp,
        // 'code': code,
        'language': "English",
      });
      print(url);
      print(body);
      final response = await http.post(url, body: body, headers: headers);
      print(response.toString());
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (responseBody['status_code'] == 200)
        return true;
      // return User.fromJson(responseBody['data']);
      else {
        // Actual response
        throw responseBody['data']['message'];
      }
    } catch (e) {
      throw e.toString();
    }
    // return User(
    //     userId: userId,
    //     firstName: 'Wajahat',
    //     lastName: 'Ali',
    //     mobileNo: '03001234567',
    //     profilePic:
    //         'https://amzsummits.com/wp-content/uploads/2019/05/Ferry-Vermeulen.jpeg');
  }

}
