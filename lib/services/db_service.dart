import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String user = "users";
class DatabaseService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUserData(Map<String, String> userData) async{
    await firestore.collection(user).doc(userData['email']).set(userData);
  }

  Future<Map<String, dynamic>?> getUserData() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final userData = await firestore.collection(user).doc(auth.currentUser!.email).get();
    return userData.data();
  }

}