import 'package:calista_ain/user/customer/cart.dart';
import 'package:calista_ain/user/customer/my_orders.dart';
import 'package:calista_ain/user/customer/products.dart';
import 'package:calista_ain/user/customer/profile.dart';
import 'package:calista_ain/user/customer/wishlist.dart';
import 'package:calista_ain/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../widgets/bottomBarItem.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _currentIndex = 0;
  final _pages = const [Products(), Cart(), Wishlist(), MyOrders()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      endDrawer: const Drawer(
        child: Profile(),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.pinkAccent.shade100,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          salomonBottomBarItem(context, Icons.home_outlined, "Home"),
          salomonBottomBarItem(context, Icons.shopping_cart_outlined, 'Cart'),
          salomonBottomBarItem(context, Icons.favorite_outline, "Wishlist"),
          salomonBottomBarItem(context, Icons.list_alt_outlined, "Orders"),
        ],
      ),
    );
  }
}
