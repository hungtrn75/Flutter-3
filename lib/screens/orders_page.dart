import 'package:flutter/material.dart';
import 'package:flutter_train_3/providers/orders.dart';
import 'package:flutter_train_3/widgets/order_list_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_train_3/widgets/main_drawer.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (ctx, i) => OrderListItem(order: orders[i]),
        ),
      ),
    );
  }
}
