import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/editProductScreen.dart';
import 'package:shop_app/widgets/mainDrawer.dart';
import 'package:shop_app/widgets/userProductItems.dart';
import '../providers/products.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItems(
                productsData.items[i].id,
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
