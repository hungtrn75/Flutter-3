import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:flutter_train_3/utils/dio.dart';
import 'dart:convert';

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
  bool isLoading = false;
  List<OrderItem> _orderItems = [];

  List<OrderItem> get orders {
    return [..._orderItems];
  }

  Future<void> fetchOrders() async {
    try {
      isLoading = true;
      final res = await http.get('/orders.json');
      final map = json.decode(res.toString()) as Map<String, dynamic>;
      if (map != null) {
        List<OrderItem> _addOrderItems = [];
        map.forEach((key, value) {
          _addOrderItems.add(
            OrderItem(
              id: key,
              amount: value['amount'],
              products: (value['products'] as List<dynamic>)
                  .map(
                    (e) => CartItem(
                      id: e['id'],
                      price: e['price'],
                      title: e['title'],
                      quantity: e['quantity'],
                    ),
                  )
                  .toList(),
              date: DateTime.parse(value['date']),
            ),
          );
        });
        print(_addOrderItems);
        _orderItems = _addOrderItems;
      } else {
        _orderItems = [];
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      final res = await http.post('/orders.json', data: {
        'amount': total,
        'date': DateTime.now().toIso8601String(),
        'products': cartProducts
            .map(
              (e) => ({
                'id': e.id,
                'title': e.title,
                'quantity': e.quantity,
                'price': e.price,
              }),
            )
            .toList(),
      });
      print(res);
      final map = json.decode(res.toString());
      _orderItems.insert(
        _orderItems.length,
        OrderItem(
          id: map['name'],
          date: DateTime.now(),
          products: cartProducts,
          amount: total,
        ),
      );
    } catch (e) {
      throw new Exception('Can not add this order!');
    }
  }
}
