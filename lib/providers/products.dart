import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_train_3/models/firebase_response.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/utils/dio.dart';

class Products with ChangeNotifier {
  bool isLoading = false;
  List<Product> _items = [];

  bool _isShowOnlyFavorites = false;

  List<Product> get items {
    return [..._items];
  }

  bool get isShowOnlyFavorites {
    return _isShowOnlyFavorites;
  }

  Future<dynamic> fetchProducts() async {
    try {
      final res = await http.get('/products.json');
      final map = json.decode(res.toString()) as Map<String, dynamic>;
      List<Product> _importProducts = [];
      if (map != null) {
        map.forEach((key, value) {
          _importProducts.add(
            Product(
              id: key,
              title: value['title'],
              price: value['price'],
              description: value['description'],
              imageUrl: value['imageUrl'],
              isFavorite: value['isFavorite'],
            ),
          );
        });
      }

      _items = _importProducts;
      notifyListeners();
      print(_importProducts);
      return Future.value(_importProducts);
    } catch (e) {
      throw e;
    } finally {}
  }

  Future<void> addProduct(Product value) async {
    try {
      Response res = await http.post('/products.json', data: {
        'title': value.title,
        'price': value.price,
        'description': value.description,
        'imageUrl': value.imageUrl,
        'isFavorite': value.isFavorite,
      });
      final map = json.decode(res.toString());
      final newProduct = Product(
        id: map["name"],
        title: value.title,
        description: value.description,
        price: value.price,
        imageUrl: value.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
    return Future.value(true);
  }

  Future<void> updateProduct(Product product) async {
    try {
      final res = await http.patch('/products/${product.id}.json', data: {
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'imageUrl': product.imageUrl,
      });

      print(res);
      final editProductIndex =
          _items.indexWhere((element) => element.id == product.id);
      _items[editProductIndex] = product;
      notifyListeners();
    } catch (e) {
      throw e;
    }

    return Future.value();
  }

  Future<void> removeProduct(String productId) async {
    final _deleteProduct =
        _items.firstWhere((element) => element.id == productId);
    final _deleteIndex =
        _items.indexWhere((element) => element.id == productId);
    try {
      _items.removeWhere((element) => element.id == productId);
      notifyListeners();
      await http.delete('/products/$productId.json');
    } catch (e) {
      _items.insert(_deleteIndex, _deleteProduct);
      notifyListeners();
      throw Exception('Can not delete this product!');
    }
  }

  void showOnlyFavorites() {
    _isShowOnlyFavorites = true;
    notifyListeners();
  }

  void showAll() {
    _isShowOnlyFavorites = false;
    notifyListeners();
  }
}
