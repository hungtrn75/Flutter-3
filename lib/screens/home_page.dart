import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:flutter_train_3/widgets/badge.dart';
import 'package:flutter_train_3/widgets/grid_product.dart';
import 'package:flutter_train_3/widgets/main_drawer.dart';
import 'package:flutter_train_3/widgets/product_item.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = Provider.of<Products>(context, listen: false);
    final itemCount = Provider.of<Cart>(context).itemCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          Badge(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.cartPage);
              },
            ),
            value: itemCount.toString(),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selected) {
              print(selected);
              switch (selected) {
                case FilterOptions.Favorite:
                  actions.showOnlyFavorites();
                  break;
                default:
                  actions.showAll();
              }
            },
            icon: Icon(Icons.filter_list),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorite'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          child: GridProduct(),
        ),
      ),
    );
  }
}
