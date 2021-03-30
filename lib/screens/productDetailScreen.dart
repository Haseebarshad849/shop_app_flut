import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;

    final productsData = Provider.of<Products>(context, listen: false);
    final loadedProduct = productsData.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Text(
              "\$${loadedProduct.price}",
              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 16),
              child: Text(
                "${loadedProduct.description}",
                style: Theme.of(context).textTheme.headline6,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
