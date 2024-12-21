import 'package:calista_ain/model/order_model.dart';
import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String users = "users";
const String products = "products";
const String orders = "orders";

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUserData(UserModel userModel) async {
    await firestore.collection(users).doc(userModel.email).set(userModel.toJson());
  }

  Future<UserModel> getUserData(String email) async {
    final userData = await firestore.collection(users).doc(email).get();
    print(userData.data());
    return UserModel.fromJson(userData.data() ?? {});
  }



  Future<bool> addProduct(ProductModel productModel) async {
    try {
      await firestore.collection(products).doc(productModel.id).set(productModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() async* {
    yield* firestore.collection(products).snapshots();
  }

  Future<bool> deleteProduct(String productID) async {
    try {
      await firestore.collection(products).doc(productID).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> placeOrder(ProductOrder order) async {
    try {
      await firestore.collection(orders).doc(order.id).set(order.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrder() async* {
    yield* firestore.collection(orders).snapshots();
  }

  Future<bool> deleteOrder(String orderID) async {
    try {
      await firestore.collection(orders).doc(orderID).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

}
