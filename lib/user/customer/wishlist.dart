import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/widgets/view_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  DatabaseService databaseService = DatabaseService();
  String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products =
              snapshot.data!.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
          List<ProductModel> wishlist = [];
          for (ProductModel product in products) {
            if (product.favourite!.contains(userID)) {
              wishlist.add(product);
            }
          }
          if (wishlist.isEmpty) {
            return Center(
              child: Image.asset("images/empty-wishlist.png"),
            );
          }
          return viewProducts(wishlist);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
