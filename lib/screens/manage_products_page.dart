import 'package:flutter/material.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:flutter_train_3/widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_train_3/widgets/main_drawer.dart';

class ManageProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.editProductPage);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        onRefresh: Provider.of<Products>(context).fetchProducts,
        backgroundColor: Theme.of(context).primaryColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: productProvider.items.length,
            itemBuilder: (ctx, index) => UserProductItem(
              product: productProvider.items[index],
            ),
          ),
        ),
      ),
    );
  }
}
