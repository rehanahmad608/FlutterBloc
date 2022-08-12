import 'package:demoapp/src/app.dart';
import 'package:flutter/material.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

void main() {
  runApp(
    RouteObserverProvider(
      create: (context) => GlobalRouteObserver()..navigation,
      child: App(),
    ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: App(),
//     );
//   }
// }
