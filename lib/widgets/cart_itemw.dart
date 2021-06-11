import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/cart.dart';

class CartItemW extends StatelessWidget {
  final double price;
  final String productId;
  final int quantity;
  final String id;
  final String title;

  CartItemW(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    // dismissible is used to swipe the card or something to be deleted
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(
          productId,
        );
      },
      key: ValueKey(id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure'),
            content: Text(
              'do you want to remove the item from the cart?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('yes'),
              ),
            ],
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.0),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        color: Colors.red,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListTile(
            leading: CircleAvatar(
              // radius: 50.0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    '\$$price',
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              'Total: \$${(price * quantity)}',
            ),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
