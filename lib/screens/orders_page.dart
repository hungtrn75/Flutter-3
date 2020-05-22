import 'package:flutter/material.dart';
import 'package:flutter_train_3/providers/orders.dart';
import 'package:flutter_train_3/widgets/order_list_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_train_3/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    Provider.of<Orders>(context, listen: false).fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    final isLoading = Provider.of<Orders>(context).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) => OrderListItem(order: orders[i]),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
        ],
      ),
    );
  }
}
