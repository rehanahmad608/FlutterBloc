import 'package:demoapp/src/bloc/user_bloc.dart';
import 'package:demoapp/src/ui/configs/routes.dart';
import 'package:demoapp/src/ui/screens/signIn_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

     return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()
        ),
      
      ],
      child: OverlaySupport(
        child: MaterialApp(
          navigatorObservers: [RouteObserverProvider.of(context)],
          debugShowCheckedModeBanner: false,
          routes: routes,
          home: const SigninScreen(),
        ),
      ),
    );
  
  }
}
