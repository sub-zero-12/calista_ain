import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/widgets/view_products.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products =
              snapshot.data!.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
          return viewProducts(products);
        } else {
          return const Center(
            child: Text("No Product Found"),
          );
        }
      },
    );
  }
}
