import 'package:flutter/material.dart';
import 'package:flutter_train_3/providers/cart.dart';
import 'package:flutter_train_3/providers/orders.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final totalAmount = Provider.of<Cart>(context).totalAmount;
    final cartProvider = Provider.of<Cart>(context);
    final cartItemList = cartProvider.items.values.toList();
    final cartItemKeys = cartProvider.items.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text('Total'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('\$$totalAmount')
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.items.length,
                itemBuilder: (ctx, i) {
                  return CartItem(
                    id: cartItemList[i].id,
                    productId: cartItemKeys[i],
                    title: cartItemList[i].title,
                    price: cartItemList[i].price,
                    quantity: cartItemList[i].quantity,
                  );
                },
              ),
            ),
            if (cartItemList.length > 0) OrderButton(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final addOrder = Provider.of<Orders>(context, listen: false).addOrder;
    final totalAmount = Provider.of<Cart>(context).totalAmount;
    final cartProvider = Provider.of<Cart>(context);
    final cartItemList = cartProvider.items.values.toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: _isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                )
              : Text(
                  'Order Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
          onPressed: () async {
            try {
              setState(() {
                _isLoading = true;
              });
              await addOrder(cartItemList, totalAmount);
              cartProvider.clear();

              Navigator.of(context).pop();
            } catch (e) {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
          },
        )
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  const CartItem({
    Key key,
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.price,
    @required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final removeCartItem = Provider.of<Cart>(context).removeCartItem;
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        removeCartItem(productId);
      },
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Do you want to remove the item from the cart'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '\$$price',
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
