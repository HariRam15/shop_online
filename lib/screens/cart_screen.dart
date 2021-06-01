import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/cart.dart';
import 'package:shop_online/providers/orders.dart';
import 'package:shop_online/widgets/cart_itemw.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Card'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                    backgroundColor: Colors.green[200],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) {
                return CartItemW(
                  //in cart items(cart.dart file) the id's,price etc are stored as key values
                  //so we have to get those values here
                  cart.items.values.toList()[index].id,
                  //here im just sending the key to the CartItemW,
                  //jst to access they they id so that i can delet it later
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].price,
                  cart.items.values.toList()[index].quantity,
                  cart.items.values.toList()[index].name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
