import 'dart:async';

import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/widgets/thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), () {Get.offAll(const SignInPage());});
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
