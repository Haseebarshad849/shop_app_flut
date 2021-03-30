import 'package:flutter/material.dart';
import 'package:shop_app/screens/ordersScreen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.15,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                'My Shop App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('Shop Home',
              style: TextStyle(
                fontSize: 18,
              ),),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            title: Text('Orders',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
              leading: Icon(Icons.celebration),
            onTap: (){
              Navigator.of(context).pushNamed(
                OrdersScreen.routeName
              );
            },
          ),
        ],
      ),
    );
  }
}
