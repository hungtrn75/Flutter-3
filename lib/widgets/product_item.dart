import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final addToCart = Provider.of<Cart>(context).addToCart;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteName.productDetailPage, arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
              color: product.isFavorite ? Colors.pink : Colors.white,
              icon: Icon(Icons.favorite),
              onPressed: () {
                product.toggleFavoriteStatus();
              }),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              addToCart(product.id, product.title, product.price);
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
