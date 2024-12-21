import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/user/customer/checkout_view.dart';
import 'package:calista_ain/widgets/elevatedButton.dart';
import 'package:calista_ain/widgets/view_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
          List<ProductModel> cart = [];
          for (ProductModel product in products) {
            if (product.cart!.contains(userID)) {
              cart.add(product);
            }
          }
          if (cart.isEmpty) {
            return Center(
              child: Image.asset(
                "images/empty-cart.png",
                // fit: BoxFit.fitHeight,
              ),
            );
          }
          return Column(
            children: [
              Expanded(child: viewProducts(cart)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: elevatedButton(
                  "Checkout",
                  () => Get.to(
                    const CheckoutView(),
                    arguments: cart,
                  ),
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: Text("No Product Found"),
          );
        }
      },
    );
  }
}
