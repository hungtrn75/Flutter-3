import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_train_3/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem order;
  OrderListItem({@required this.order});

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$${widget.order.amount}'),
                ),
              ),
            ),
            title: Text(
              DateFormat('dd/MM/yyyy hh:mm:ss').format(widget.order.date),
            ),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Container(
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              e.title,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text('${e.quantity} x \$${e.price}')
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              height: min(125, widget.order.products.length * 25.0 + 25),
              width: double.infinity,
            )
        ],
      ),
    );
  }
}
