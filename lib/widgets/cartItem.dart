import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        padding: EdgeInsets.only(right: 15),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (dismissed) {
        final cart = Provider.of<Cart>(context,listen: false);
        cart.removeItem(productId);
      },

      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            title: Text(title),
            subtitle: Text("Total: \$${price * quantity}"),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: FittedBox(
                child: Text(
                  "\$${price.toString()}",
                ),
              ),
            ),
            trailing: Text("X $quantity"),
          ),
        ),
      ),
    );
  }
}
