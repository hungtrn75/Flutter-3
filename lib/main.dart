import 'package:flutter/material.dart';

import 'navigator/route_name.dart';
import 'navigator/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter T2',
      theme: ThemeData(
          fontFamily: 'Raleway',
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Colors.black,
              ),
              title: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w700))),
      initialRoute: RouteName.homePage,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
