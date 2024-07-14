import 'package:calista_ain/authentication/reset_password.dart';
import 'package:calista_ain/authentication/sign_up.dart';
import 'package:calista_ain/services/auth_service.dart';
import 'package:calista_ain/widgets/elevatedButton.dart';
import 'package:calista_ain/widgets/outlineButton.dart';
import 'package:calista_ain/widgets/textButton.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:calista_ain/widgets/thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visibility = true;

  Future<void> login() async {
    AuthServices authService = AuthServices();
    await authService.login(email.text.trim(), password.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 100,
                width: 100,
                child: thumbnail(),
              ),
              customFormField(
                email,
                "Enter Email",
                Icons.email_outlined,
                TextInputType.text,
                (value) {},
              ),
              customFormField(
                password,
                "Enter Password",
                Icons.lock_outline,
                TextInputType.text,
                (value) {},
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                  icon:
                      visibility ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                ),
                visible: visibility,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: textButton(
                  'Forget Password',
                  () {
                    Get.to(() => const ResetPassword());
                  },
                ),
              ),
              elevatedButton(
                "Sign In",
                login,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 20,
                child: const Text("Create an account if you don't have"),
              ),
              outlineButton("Sign Up", () {
                Get.off(() => const SignUpPage());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
