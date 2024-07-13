import 'package:calista_ain/widgets/elevatedButton.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your email and then goto your email inbox. A link will be sent there by "
                "which you can reset your password",
                textAlign: TextAlign.center,
              ),
              customFormField(email, "Enter Email", Icons.email, TextInputType.text, (val) {}),
              elevatedButton("Sent Link", () {})
            ],
          ),
        ),
      ),
    );
  }
}
