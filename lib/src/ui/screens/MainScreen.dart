import 'package:demoapp/src/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/Main-Screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
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
          body: Center(
            child: Container(
                child: (state is UserLoggedIn)
                    ? Column(children: [
                        SizedBox(height: 50),
                        Text(state.user.firstName),
                        Text(state.user.lastName),
                        Text(state.user.mobileNo),
                        Text(state.user.userId),
                      ])
                    : 
                    Text("main screen")),
          ),
        );
      },
    );
  }
}
