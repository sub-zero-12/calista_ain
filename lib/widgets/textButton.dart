import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textButton(String name, Function() onPressed) {
  return TextButton(
    onPressed: onPressed,
    // style: ElevatedButton.styleFrom(
    //   backgroundColor: Colors.pinkAccent,
    // ),
    child: Text(
      name,
      // style: GoogleFonts.alata(
      //   color: Colors.white,
      //   fontSize: 18,
      // ),
    ),
  );
}
