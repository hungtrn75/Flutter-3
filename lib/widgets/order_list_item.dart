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

class _OrderListItemState extends State<OrderListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;
  Animation<double> rotate;
  bool _expanded = false;
  @override
  void initState() {
    _animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    rotate = Tween<double>(begin: 0, end: 0.5).animate(_animation);
    super.initState();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(125, widget.order.products.length * 25.0 + 25) + 64.0
          : 65,
      child: Card(
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
              trailing: RotationTransition(
                turns: rotate,
                child: IconButton(
                    icon: Icon(Icons.expand_less),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                      if (_expanded) {
                        _animation.forward();
                      } else {
                        _animation.reverse();
                      }
                    }),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(125, widget.order.products.length * 25.0 + 25)
                  : 0,
              child: Container(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
