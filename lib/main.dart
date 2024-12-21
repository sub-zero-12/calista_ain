import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/common_pages/splash.dart';
import 'package:calista_ain/firebase_options.dart';
import 'package:calista_ain/user/admin/admin_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});/// constructor
  /// If the method name is exactly same as class name, then this type of method
  /// is called constructor. It used for passing important data to create a object
  /// of a class.
  @override /// Polymorphism -> Overriding
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calista Ain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent.shade100,
        ),
        // useMaterial3: true,
        textTheme: GoogleFonts.adaminaTextTheme(),
      ),
      home: const Splash(),
    );
  }
}








