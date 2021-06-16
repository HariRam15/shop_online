import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_online/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shoponline-a1a4f-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedDate = json.decode(response.body) as Map<String, dynamic>;
    if (extractedDate == null) {
      return;
    }
    extractedDate.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        products: (orderData['products'] as List<dynamic>)
            .map((e) => CartItem(
                  id: e['id'],
                  name: e['title'],
                  price: e['price'],
                  quantity: e['quantity'],
                ))
            .toList(),
        dateTime: DateTime.parse(orderData['dateTime']),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shoponline-a1a4f-default-rtdb.firebaseio.com/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'products': cartProducts
            .map((e) => {
                  'id': e.id,
                  'title': e.name,
                  'quantity': e.quantity,
                  'price': e.price
                })
            .toList(),
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );

    notifyListeners();
  }
}
