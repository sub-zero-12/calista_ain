import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/services/auth_service.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/utilities/validation.dart';
import 'package:calista_ain/widgets/elevatedButton.dart';
import 'package:calista_ain/widgets/outlineButton.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:calista_ain/widgets/thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool visibility = true;
  final key = GlobalKey<FormState>();

  Future<void> signUp() async {
    AuthServices authServices = AuthServices();
    await authServices.signUp(email.text.trim(), password.text.trim());
  }

  Future<void> addUserData() async {
    DatabaseService databaseService = DatabaseService();
    Map<String, String> userData = {
      "name": name.text.trim(),
      "email": email.text.trim(),
      "number": number.text.trim(),
    };
    await databaseService.addUserData(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: key,
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
                  name,
                  "Enter Name",
                  Icons.person_outlined,
                  TextInputType.text,
                  nameValidation,
                ),
                customFormField(
                  email,
                  "Enter Email",
                  Icons.email_outlined,
                  TextInputType.text,
                  emailValidation,
                ),
                customFormField(
                  number,
                  "Enter Number",
                  Icons.phone_outlined,
                  TextInputType.text,
                  numberValidation,
                ),
                customFormField(
                  password,
                  "Enter Password",
                  Icons.lock_outline,
                  TextInputType.text,
                  passwordValidation,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: visibility
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  visible: visibility,
                ),
                customFormField(
                  confirmPassword,
                  "Re-enter Password",
                  Icons.lock_outline,
                  TextInputType.text,
                  (value) {
                    if (confirmPassword.text.trim().isEmpty) {
                      return "Please Re-enter password";
                    } else if (confirmPassword.text != password.text) {
                      return "Password not matched";
                    }
                    return null;
                  },
                  visible: visibility,
                ),
                elevatedButton(
                  "Sign Up",
                    (){
                    print(key.currentState!.validate());
                      if (key.currentState!.validate()) {
                        print("ABC");
                        signUp();
                        addUserData();
                      }
                    }
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 20,
                  child: const Text("If you have account"),
                ),
                outlineButton(
                  "Sign In",
                  () {
                    Get.off(() => const SignInPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
