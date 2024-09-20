import 'package:calista_ain/widgets/view_products.dart';
import 'package:flutter/material.dart';
class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return viewProducts();
  }
}
