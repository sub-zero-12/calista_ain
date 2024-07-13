
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar successSnackBar(String message) {
  return GetSnackBar(
    message: message,
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
  );
}

GetSnackBar failedSnackBar(String message) {
  return GetSnackBar(
    message: message,
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
  );
}