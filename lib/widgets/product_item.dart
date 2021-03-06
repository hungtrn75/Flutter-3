import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/auth.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final authProvider = Provider.of<Auth>(context);
    final cartProvider = Provider.of<Cart>(context);
    final scaffold = Scaffold.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteName.productDetailPage, arguments: product);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
              placeholder: AssetImage(
                'assets/images/placeholder.png',
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
              color: product.isFavorite ? Colors.pink : Colors.white,
              icon: Icon(Icons.favorite),
              onPressed: () {
                product
                    .toggleFavoriteStatus(
                        authProvider.userToken, authProvider.userId)
                    .catchError((e) {
                  scaffold.hideCurrentSnackBar();
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                });
              }),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cartProvider.addToCart(product.id, product.title, product.price);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added ${product.title} to cart',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartProvider.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
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
