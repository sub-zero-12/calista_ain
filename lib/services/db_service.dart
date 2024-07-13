import 'package:cloud_firestore/cloud_firestore.dart';

String user = "users";
class DatabaseService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(Map<String, String> userData) async{
    await firestore.collection(user).doc(userData['email']).set(userData);
  }
}