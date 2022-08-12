part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class Signin extends UserEvent {
  final String phoneNum;
  Signin({required this.phoneNum});
}

class Signup extends UserEvent {
  final String phoneNum, fName, lName;

  Signup({required this.phoneNum, required this.fName, required this.lName});
}

class Verify extends UserEvent {
  final String code;
  final String phoneNum;
  final String userId;
  final bool isSignup;
  Verify({required this.userId, required this.code, required this.phoneNum, required this.isSignup});
}

class ResendOTP extends UserEvent {
  final String userId;
  // final bool isSignup;
  final String phoneNum;
  ResendOTP(
      {required this.userId,
      // required this.isSignup,
      required this.phoneNum});
}

class SuccessfulLoggedIn extends UserEvent {}
