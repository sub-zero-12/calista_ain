import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/user/customer/customer_home.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../user/admin/admin_home.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      Get.showSnackbar(
        successSnackBar("A verification link is sent to $email. Verify your "
            "account to login"),
      );
      Get.offAll(() => const SignInPage());
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(failedSnackBar(e.message!));
    } catch (e) {
      Get.showSnackbar(failedSnackBar(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final credential =
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      String adminEmail = "calistaain@gmail.com";
      String adminPassword = "admin123";
      if (email.toLowerCase() == adminEmail && password.toLowerCase() == adminPassword) {
        Get.offAll(() => const AdminHomePage());
      }
      else if (credential.user!.emailVerified) {
        Get.offAll(() => const CustomerHomePage());
      } else {
        await credential.user!.sendEmailVerification();
        Get.showSnackbar(
          successSnackBar("A verification link is sent to $email. Verify your "
              "account to login"),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(failedSnackBar(e.message!));
    } catch (e) {
      Get.showSnackbar(failedSnackBar(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).whenComplete(() {
        Get.showSnackbar(successSnackBar("A link is sent to your email.Please check your email "
            "inbox and spam."));
      });
    } on FirebaseException catch (e) {
      Get.showSnackbar(failedSnackBar(e.message!));
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
