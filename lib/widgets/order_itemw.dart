import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_online/providers/orders.dart';

class OrderItemW extends StatefulWidget {
  final OrderItem order;
  OrderItemW(this.order);

  @override
  _OrderItemWState createState() => _OrderItemWState();
}

class _OrderItemWState extends State<OrderItemW> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(widget.order.dateTime),
            ),
            trailing: IconButton(
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.all(8),
              height: min(
                widget.order.products.length * 20.0 + 10,
                108,
              ),
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.name,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            '${e.quantity} x \$${e.price}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
