import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBarItem salomonBottomBarItem(IconData iconData, String title) {
  return SalomonBottomBarItem(
    icon: Icon(iconData, color: Colors.white),
    title: Text(
      title,
      style: GoogleFonts.alata(color: Colors.white),
    ),
    // selectedColor: Colors.black,
  );
}
