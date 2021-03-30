import 'package:flutter/foundation.dart';
import './cart.dart';
// import '';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _items = [];

  List<OrderItems> get items {
    return [..._items];
  }

  void addOrderItems(List<CartItem> cartProducts, double totalPrice) {
    _items.insert(0, OrderItems(
      id: DateTime.now().toString(),
      amount: totalPrice,
      products: cartProducts,
      dateTime: DateTime.now(),
    ));
    notifyListeners();
  }
}
