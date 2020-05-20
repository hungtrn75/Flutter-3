import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orders {
    return [..._orderItems];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orderItems.insert(
      _orderItems.length,
      OrderItem(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        products: cartProducts,
        amount: total,
      ),
    );
  }
}
