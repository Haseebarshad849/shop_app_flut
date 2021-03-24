import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widgets
import '../widgets/productItem.dart';

// Provider
import '../providers/products.dart';


class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData =Provider.of<Products>(context);
    final products = showFav ? productsData.favoritesProducts: productsData.items;

    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3/2,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
