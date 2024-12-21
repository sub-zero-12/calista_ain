
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(context) {
  return AppBar(
    title: const Text("Calista Ain"),
    centerTitle: true,
    titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.pinkAccent.shade100,
  );
}