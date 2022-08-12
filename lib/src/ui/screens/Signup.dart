import 'package:demoapp/src/bloc/user_bloc.dart';
import 'package:demoapp/src/models/User.dart';
import 'package:demoapp/src/ui/screens/MainScreen.dart';
import 'package:demoapp/src/ui/screens/otp_Verfication_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-up';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSignupError) {
          print('Error signup Scaffold');

          print(state.error);
        } else if (state is UserLoggedIn) {
          Navigator.of(context).pushNamed(MainScreen.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                size: 36,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color.fromRGBO(25, 164, 153, 1),
            elevation: 0,
          ),
          backgroundColor: Color.fromRGBO(25, 164, 153, 1),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: firstnamecontroller,
                  decoration: InputDecoration(
                    labelText: "FIRST NAME",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: lastnamecontroller,
                  decoration: InputDecoration(
                    labelText: "LAST NAME",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 20, right: 20),
              //   child: TextField(
              //     controller: phonenumbercontroller,
              //     decoration: InputDecoration(
              //       labelText: "Phone number",
              //       enabledBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(color: Colors.white)),
              //       focusedBorder: UnderlineInputBorder(
              //           borderSide: BorderSide(color: Colors.white)),
              //       labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: (state is! UserLoading)
                        ? FloatingActionButton(
                            heroTag: 3,
                            onPressed: () {
                              if(state is UserVerified){
                                // print(state.phoneNum);
                              BlocProvider.of<UserBloc>(context).add(Signup(
                                  phoneNum: state.phoneNum  ,
                                  fName: firstnamecontroller.text,
                                  lName: lastnamecontroller.text));
                             }
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
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            )),
                          ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
