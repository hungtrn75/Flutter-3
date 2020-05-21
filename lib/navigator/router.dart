import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/screens/cart_page.dart';
import 'package:flutter_train_3/screens/edit_product_page.dart';
import 'package:flutter_train_3/screens/home_page.dart';
import 'package:flutter_train_3/screens/manage_products_page.dart';
import 'package:flutter_train_3/screens/orders_page.dart';
import 'package:flutter_train_3/screens/product_detail_page.dart';
import 'package:flutter_train_3/screens/products_order_page.dart';

import 'route_name.dart';

class Router {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.manageProducts:
        return MaterialPageRoute(builder: (context) => ManageProductsPage());
      case RouteName.productsPage:
        return MaterialPageRoute(builder: (context) => ProductsOrderPage());
      case RouteName.ordersPage:
        return MaterialPageRoute(builder: (context) => OrdersPage());
      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RouteName.cartPage:
        return MaterialPageRoute(builder: (context) => CartPage());
      case RouteName.editProductPage:
        final Product product = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => EditProductPage(product));
      case RouteName.productDetailPage:
        final Product product = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ProductDetailPage(product));
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
