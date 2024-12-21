import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/services/auth_service.dart';
import 'package:calista_ain/user/admin/add_product.dart';
import 'package:calista_ain/user/admin/all_orders.dart';
import 'package:calista_ain/user/admin/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/bottomBarItem.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;
  final _pages = const [AllProducts(), AddProduct(), AllOrders()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calista Ain"),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthServices().logout();
              Get.offAll(() => const SignInPage());
            },
            icon: const Icon(Icons.logout, color: Colors.white,),
          ),
        ],
        backgroundColor: Colors.pinkAccent.shade100,
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
          /// Home
          salomonBottomBarItem(context, Icons.home_outlined, "Home"),
          salomonBottomBarItem(context, Icons.add_circle_outline, "Add Product"),
          salomonBottomBarItem(context, Icons.list_alt_outlined, "All Orders"),
        ],
      ),
    );
  }
}
