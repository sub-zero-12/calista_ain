import 'package:calista_ain/authentication/sign_in.dart';
import 'package:calista_ain/user/customer/customer_home.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
      if (credential.user!.emailVerified) {
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



  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }
}
