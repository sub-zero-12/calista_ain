import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget elevatedButton(String name, Function() onPressed, {double width=200}) {
  return SizedBox(
    // height: 50,
    width: width,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        // style: TextStyle(
        //   fontSize: 18,
        // ),
      ),
    ),
  );
}
