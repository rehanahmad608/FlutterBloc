import 'package:demoapp/src/bloc/user_bloc.dart';
import 'package:demoapp/src/models/User.dart';
import 'package:demoapp/src/models/User.dart';
import 'package:demoapp/src/ui/screens/MainScreen.dart';
import 'package:demoapp/src/ui/screens/Signup.dart';
import 'package:demoapp/src/ui/screens/otp_Verfication_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-in';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LogInError) {
          print('Error log in Scaffold');

          print(state.error);
        } else if (state is UserVerify) {
          if (state.shouldPush == true) {
            Navigator.of(context).pushNamed(OTPScreen.routeName);
          }

          if (state.shouldPush == false) {
            Navigator.of(context).pushNamed(SignupScreen.routeName);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(25, 164, 153, 1),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Signin',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.only(right: 20),
                  child: (state is! UserLoading)
                      ? FloatingActionButton(
                          heroTag: 2,
                          onPressed: () {
                            BlocProvider.of<UserBloc>(context)
                                .add(Signin(phoneNum: phoneController.text));
                          },
                          child: Icon(
                            Icons.navigate_next,
                            color: Color.fromRGBO(25, 164, 153, 1),
                          ),
                          backgroundColor: Colors.white,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.green),
                          )),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
