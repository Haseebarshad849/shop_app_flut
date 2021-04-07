import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cartScreen.dart';
import 'package:shop_app/screens/editProductScreen.dart';
import 'package:shop_app/screens/ordersScreen.dart';
import 'package:shop_app/screens/productDetailScreen.dart';
import 'package:shop_app/screens/userProductScreen.dart';
import 'screens/productOverviewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductOverviewScreen.routeName: (ctx)=> ProductOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName:(ctx)=> CartScreen(),
          OrdersScreen.routeName:(ctx)=> OrdersScreen(),
          UserProductScreen.routeName:(ctx)=> UserProductScreen(),
          EditProductScreen.routeName: (ctx)=> EditProductScreen(),
        },
      ),
    );
  }
}
