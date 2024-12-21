import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget outlineButton(String name, Function() onPressed, {double width=200}) {
  return SizedBox(
    width: width,
    child: OutlinedButton(
      onPressed: onPressed,
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: Colors.pinkAccent,
      // ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}
