import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget outlineButton(String name, Function() onPressed) {
  return SizedBox(
    height: 50,
    width: 200,
    child: OutlinedButton(
      onPressed: onPressed,
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: Colors.pinkAccent,
      // ),
      child: Text(
        name,
        style: GoogleFonts.alata(
          fontSize: 18,
        ),
      ),
    ),
  );
}
