import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget elevatedButton(String name, Function() onPressed) {
  return SizedBox(
    height: 50,
    width: 200,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      child: Text(
        name,
        style: GoogleFonts.alata(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ),
  );
}
