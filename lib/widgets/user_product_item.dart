import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';
import 'package:flutter_train_3/navigator/route_name.dart';
import 'package:flutter_train_3/providers/products.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem({@required this.product});
  @override
  Widget build(BuildContext context) {
    final removeProduct = Provider.of<Products>(context).removeProduct;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Image.network(product.imageUrl),
        ),
        title: Text(product.title),
        trailing: Container(
          width: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RouteName.editProductPage,
                      arguments: product,
                    );
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Do you want to remove the product'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              removeProduct(product.id);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
