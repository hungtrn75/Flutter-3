import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/utils/dio.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Red Shirt 2',
      description: 'A red shirt - it is pretty red!',
      price: 39.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Red Shirt 3',
      description: 'A red shirt - it is pretty red!',
      price: 19.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Red Shirt 4',
      description: 'A red shirt - it is pretty red!',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    )
  ];

  bool _isShowOnlyFavorites = false;

  List<Product> get items {
    return [..._items];
  }

  bool get isShowOnlyFavorites {
    return _isShowOnlyFavorites;
  }

  void addProduct(Product value) async {
    Response<Map> res = await http.post('/products.json', data: {
      'title': value.title,
      'price': value.price,
      'description': value.description,
      'imageUrl': value.imageUrl,
      'isFavorite': value.isFavorite,
    });
    print(res);
    _items.add(value);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final editProductIndex =
        _items.indexWhere((element) => element.id == product.id);
    print(editProductIndex);
    _items[editProductIndex] = product;
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
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
