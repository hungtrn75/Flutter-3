import 'package:flutter/material.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:flutter_train_3/providers/orders.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:provider/provider.dart';

import 'navigator/route_name.dart';
import 'navigator/router.dart';

void main() => runApp(
      MultiProvider(
        child: MyApp(),
        providers: [
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Orders(),
          ),
        ],
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter T2',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.green,
        accentColor: Colors.white,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Colors.black,
              ),
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w700),
            ),
      ),
      initialRoute: RouteName.homePage,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
