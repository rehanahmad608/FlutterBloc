part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoggedIn extends UserState{ final User user;
  UserLoggedIn({required this.user});}

class LogInError extends UserState {
  final String error;
  LogInError({required this.error});
}

class UserVerify extends UserState{
  final String userId;
  final String phoneNum;
  final bool shouldPush;
  final bool isSignup;
  UserVerify({
    required this.userId,
    required this.phoneNum,
    required this.shouldPush,
    required this.isSignup,
  });
}

class UserVerified extends UserState{   final String phoneNum;
UserVerified({required this.phoneNum});
}

class VerificationError extends UserState {
  final String error;
  final String userId;
  // final bool isSignup;
  final String phoneNum;
  VerificationError(
      {required this.error,
      required this.userId,
      // required this.isSignup,
      required this.phoneNum});
}

class UserResendOTP extends UserState {
  final userId;
  // final isSignup;
  final phoneNum;
  UserResendOTP(
      {@required this.userId,
      // @required this.isSignup,
      @required this.phoneNum});
}

class UserSignupError extends UserState{
   final String error;
  UserSignupError({required this.error});
}






