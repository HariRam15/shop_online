import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  CartItem(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  //this gives amount of products
  int get itemCount {
    return _items.length;
  }

//this is to show the total amount in cart screen
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    //items in the cart will check wheather the item is already
    //present in cart, if yes then the quantity should be increaased.
    if (_items.containsKey(productId)) {
      //change quantity...
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              name: existingCartItem.name,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            name: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

//to removie the item from cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

//need to clear the cart once the order is placed
  void clear() {
    _items = {};
    notifyListeners();
  }
}
