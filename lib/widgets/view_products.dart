
import 'package:calista_ain/data/products.dart';
import 'package:flutter/material.dart';

Widget viewProducts(){
  return GridView.builder(
    itemCount: MyProducts.products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (context, index) {
      final product = MyProducts.products[index];
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                product['image'],
                height: 120,
              ),
              Text(product['title']),
              Text("${product['price']} BDT"),
            ],
          ),
        ),
      );
    },
  );
}