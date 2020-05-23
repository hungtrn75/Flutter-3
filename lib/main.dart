import 'package:flutter/material.dart';
import 'package:flutter_train_3/providers/auth.dart';
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
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(),
            update: (_, auth, prevProducts) => Products(
              userToken: auth.userToken,
              getRefreshToken: auth.getRefreshToken,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(),
            update: (_, auth, prevProducts) => Orders(
              userToken: auth.userToken,
            ),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
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
      initialRoute: RouteName.authPage,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
