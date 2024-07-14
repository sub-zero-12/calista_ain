import 'package:calista_ain/services/auth_service.dart';
import 'package:calista_ain/widgets/elevatedButton.dart';
import 'package:calista_ain/widgets/outlineButton.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  Future<void> resetPassword() async {
       AuthServices authServices = AuthServices();
       authServices.resetPassword(email.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your email and click Send Link button. A password reset link will be sent "
                    "to your email by which you can reset your password",
                textAlign: TextAlign.center,
                style: GoogleFonts.alata(fontSize: 16),
              ),
              customFormField(email, "Enter Email", Icons.email, TextInputType.text, (val) {}),
              elevatedButton("Send Link", resetPassword),
              const SizedBox(height: 10),
              outlineButton("Go Back", () => Get.back()),
            ],
          ),
        ),
      ),
    );
  }
}
