import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_train_3/utils/dio.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite = false;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite,
  });

  Future<void> toggleFavoriteStatus() async {
    try {
      isFavorite = !isFavorite;
      notifyListeners();
      await http.patch('/products/$id.json', data: {
        'title': title,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
      });
    } catch (e) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw Exception('Can not add this product to favorite list!');
    }
  }
}
