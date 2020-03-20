import 'package:flutter/material.dart';
import 'package:flutter_train_3/screens/home_page.dart';

import 'route_name.dart';

class Router {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.manageProducts:
        return MaterialPageRoute(builder: (context) => TabsScreen());
      case RouteName.productsPage:
        return MaterialPageRoute(builder: (context) => BottomBarScreen());
      case RouteName.ordersPage:
        return MaterialPageRoute(builder: (context) => BottomBarScreen());
      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
