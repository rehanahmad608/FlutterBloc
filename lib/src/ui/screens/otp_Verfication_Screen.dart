import 'package:demoapp/src/bloc/user_bloc.dart';
import 'package:demoapp/src/models/User.dart';
import 'package:demoapp/src/ui/screens/MainScreen.dart';
import 'package:demoapp/src/ui/screens/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);
  static const routeName = '/OTP-screen';

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  String currentText = "";
   bool isSignup = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
      if(state is UserVerified){
        Navigator.of(context).pushNamed(SignupScreen.routeName);
      }
      else if (state is VerificationError){
        print(state.error);
      }
      else if (state is UserLoggedIn){
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
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              Container(
                  // height: height,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      selectedColor: Colors.white,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    // backgroundColor: Colors.white,
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: false,
                    controller: otpController,
                    keyboardType: TextInputType.number,

                    onCompleted: (v) {
                      print("Completed");
                      setState(() {
                        currentText = v;
                      });
                    },
                    onChanged: (value) {
                      print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                  )),
              SizedBox(
                height: 20,
              ),

              InkWell(
                onTap:(){} ,
                child: Text("resend OTP",
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
              ),
               SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child:
                           (state is! UserLoading)
                          ?
                          FloatingActionButton(
                        heroTag: 3,
                        onPressed: () {
                          if(state is UserVerify){
                            // print(state.user.userId);
                          BlocProvider.of<UserBloc>(context).add(Verify(
                            userId: state.userId  ,
                            code: otpController.text,
                            isSignup: state.isSignup,
                            phoneNum: state.phoneNum));
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
