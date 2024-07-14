import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/bottomBarItem.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
          salomonBottomBarItem(Icons.add_circle_outline, "Add Product"),
          salomonBottomBarItem(Icons.list_alt_outlined, "All Orders"),
        ],
      ),
    );
  }
}
