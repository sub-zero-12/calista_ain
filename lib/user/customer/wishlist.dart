import 'package:calista_ain/widgets/view_products.dart';
import 'package:flutter/material.dart';
class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return viewProducts();
  }
}
