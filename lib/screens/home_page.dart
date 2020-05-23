import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/auth.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:flutter_train_3/widgets/badge.dart';
import 'package:flutter_train_3/widgets/grid_product.dart';
import 'package:flutter_train_3/widgets/main_drawer.dart';
import 'package:flutter_train_3/widgets/product_item.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final actions = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          CartButton(),
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
      body: FutureBuilder(
          future: Provider.of<Products>(context, listen: false).fetchProducts(),
          builder: (ctx, snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = GridProduct();
            } else if (snapshot.hasError) {
              child = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 40,
                    ),
                    child: Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              );
            } else {
              child = Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              );
            }
            return child;
          }),
      // body: isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(
      //           backgroundColor: Theme.of(context).primaryColor,
      //         ),
      //       )
      //     : GridProduct(),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemCount = Provider.of<Cart>(context).itemCount;
    final scaffold = Scaffold.of(context);
    return Badge(
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          scaffold.hideCurrentSnackBar();
          Navigator.of(context).pushNamed(RouteName.cartPage);
        },
      ),
      value: itemCount.toString(),
    );
  }
}
