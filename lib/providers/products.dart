import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';

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

  void addProduct(Product value) {
    _items.add(value);
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
