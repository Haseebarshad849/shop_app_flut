import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' as ord;
import '../widgets/orderItems.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<ord.Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, i) => OrderItems(
          orders.items[i],
        ),
      ),
    );
  }
}
