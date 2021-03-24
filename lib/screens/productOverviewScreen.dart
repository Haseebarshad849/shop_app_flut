import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/21.1%20badge.dart';
import '../widgets/productsGrid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop App'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showFavorite = true;
                  } else {
                    _showFavorite = false;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.countItem.toString(),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showFavorite),
    );
  }
}
