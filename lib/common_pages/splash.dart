import 'dart:async';

import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/user/admin/admin_home.dart';
import 'package:calista_ain/widgets/thumbnail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user/customer/customer_home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void selectRoute() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String admin = "calistaain@gmail.com";
      if (user.email!.toLowerCase() == admin) {
        Get.offAll(() => const AdminHomePage());
      } else {
        Get.offAll(() => const CustomerHomePage());
      }
    } else {
      Get.offAll(() => const SignInPage());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 3),
      selectRoute
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            thumbnail(),
            const SizedBox(height: 30),
            const Text(
              "Calista Ain",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
