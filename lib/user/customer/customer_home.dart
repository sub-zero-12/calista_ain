import 'package:calista_ain/user/customer/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/bottomBarItem.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calista Ain"),
        centerTitle: true,
        titleTextStyle: GoogleFonts.alata(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      endDrawer: const Drawer(

        child: Profile(),
      ),
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
          salomonBottomBarItem(Icons.home_outlined, "Home"),
          salomonBottomBarItem(Icons.shopping_cart_outlined, 'Cart'),
          salomonBottomBarItem(Icons.favorite_outline, "Wishlist"),
          salomonBottomBarItem(Icons.list_alt_outlined, "Orders"),
        ],
      ),
    );
  }
}
