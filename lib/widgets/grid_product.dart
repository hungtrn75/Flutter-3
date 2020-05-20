import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:flutter_train_3/screens/home_page.dart';
import 'package:flutter_train_3/widgets/product_item.dart';
import 'package:provider/provider.dart';

class GridProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isShowOnlyFavorites =
        context.watch<Products>().isShowOnlyFavorites;
    final products = context.watch<Products>().items;
    final List<Product> filtedProducts = !isShowOnlyFavorites
        ? products
        : products.where((product) => product.isFavorite).toList();
    return GridView.builder(
      itemCount: filtedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: filtedProducts[i],
        child: ProductItem(),
      ),
      padding: const EdgeInsets.all(10),
    );
  }
}
