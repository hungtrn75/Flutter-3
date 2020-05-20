import 'package:flutter/material.dart';
import 'package:flutter_train_3/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
