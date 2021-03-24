import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../providers/product.dart';
import '../screens/productDetailScreen.dart';


class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              product.isFavorite? Icons.favorite:Icons.favorite_outline,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            onPressed: (){
              product.toggleFavoriteStatus();
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            onPressed: (){
              cart.addCartItem(product.id, product.price, product.title);
            },
          ),
        ),
      ),
    );
  }
}
