import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/model/user_model.dart';
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
  bool invisibility = true;
  final key = GlobalKey<FormState>();

  Future<void> signUp() async {
    AuthServices authServices = AuthServices();

    await authServices.signUp(email.text.trim(), password.text.trim());
  }

  Future<void> addUserData() async {
    DatabaseService databaseService = DatabaseService();
    UserModel userModel = UserModel(
      name: name.text.trim(),
      email: email.text.trim(),
      number: number.text.trim(),
    );
    await databaseService.addUserData(userModel);
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
                  name, // controller
                  "Enter Name", // label
                  Icons.person_outlined, // IconData
                  TextInputType.text,
                  1, // InputType
                  nameValidation, // validator
                ),
                customFormField(
                  email,
                  "Enter Email",
                  Icons.email_outlined,
                  TextInputType.emailAddress,
                  1,
                  emailValidation,
                ),
                customFormField(
                  number,
                  "Enter Number",
                  Icons.phone_outlined,
                  TextInputType.phone,
                  1,
                  numberValidation,
                ),
                customFormField(
                  password,
                  "Enter Password",
                  Icons.lock_outline,
                  TextInputType.text,
                  1,
                  passwordValidation,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        // visibility =
                        invisibility = !invisibility;
                      });
                    },
                    icon: invisibility
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  visible: invisibility,
                ),
                customFormField(
                  confirmPassword,
                  "Re-enter Password",
                  Icons.lock_outline,
                  TextInputType.text,
                  1,
                  (value) {
                    if (confirmPassword.text.trim().isEmpty) {
                      return "Please Re-enter password";
                    } else if (confirmPassword.text != password.text) {
                      return "Password not matched";
                    }
                    return null;
                  },
                  visible: invisibility,
                ),
                elevatedButton("Sign Up", () async {
                  if (key.currentState!.validate()) {
                    signUp();///authentication
                    addUserData();/// Cloud Firestore
                  }
                }),
                Container(
                  margin: const EdgeInsets.all(10),
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
