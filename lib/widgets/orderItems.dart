import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//providers
import '../providers/orders.dart' as ord;

class OrderItems extends StatefulWidget {
  final ord.OrderItems orders;

  OrderItems(this.orders);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<ord.Orders>(context);

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 15,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.orders.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.orders.dateTime),
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            trailing: IconButton(
              icon: Icon(_expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          if (_expand)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orders.products.length * 0.20 + 90, 90),
              color: Colors.purple[300],
              child: ListView(
                children: widget.orders.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${prod.title}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${prod.quantity} x \$${prod.price} ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              // color: Colors.red,
            ),
        ],
      ),
    );
  }
}
