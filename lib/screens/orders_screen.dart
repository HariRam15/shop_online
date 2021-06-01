import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/providers/orders.dart';
import 'package:shop_online/widgets/app_drawer.dart';
import 'package:shop_online/widgets/order_itemw.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) => OrderItemW(ordersData.orders[index]),
      ),
    );
  }
}
