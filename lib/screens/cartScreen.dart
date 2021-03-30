import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cartItem.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart Item'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Total',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5,
                  ),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    "\$ ${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme
                      .of(context)
                      .primaryColor,
                ),
                TextButton(
                  child: Text('ORDER NOW', style: TextStyle(color: Theme
                      .of(context)
                      .primaryColor),),
                  onPressed: () {
                    Provider.of<Orders>(context,listen: false).addOrderItems(cart.items.values.toList(), cart.totalAmount);
                    cart.clearCart();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i)=> CartItem(
                cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity
              ),

            ),
          ),
        ],
      ),
    );
  }
}
