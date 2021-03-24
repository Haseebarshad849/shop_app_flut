import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    final productId=ModalRoute.of(context).settings.arguments;

    final productsData=Provider.of<Products>(context,listen: false);
    final loadedProduct = productsData.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.4,
            child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover,),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),
          Text(loadedProduct.description,style: Theme.of(context).textTheme.headline6,),
        ],
      ),
    );
  }
}
