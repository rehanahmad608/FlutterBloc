// import 'package:demoapp/src/bloc/user_bloc.dart';
import 'package:demoapp/src/ui/screens/MainScreen.dart';
import 'package:demoapp/src/ui/screens/otp_Verfication_Screen.dart';
import 'package:demoapp/src/ui/screens/signIn_Screen.dart';
import 'package:demoapp/src/ui/screens/Signup.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  MainScreen.routeName: (ctx) => MainScreen(),
 
  SigninScreen.routeName: (ctx) => SigninScreen(),
  SignupScreen.routeName: (ctx) => SignupScreen(),
  OTPScreen.routeName: (ctx) => OTPScreen(),

 
  
};
