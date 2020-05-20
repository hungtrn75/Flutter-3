import 'package:flutter/material.dart';
import 'package:flutter_train_3/widgets/main_drawer.dart';

class ProductsOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Order'),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Column(),
      ),
    );
  }
}
