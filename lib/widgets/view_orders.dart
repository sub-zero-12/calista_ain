import 'package:calista_ain/data/products.dart';
import 'package:flutter/material.dart';

Widget viewOrders() {
  return ListView.builder(
    itemCount: MyProducts.products.length,
    itemBuilder: (context, index) {
      final product = MyProducts.products[index];
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(product['image']),
          ),
          title: Text(product['title']),
          subtitle: const Text("Order Status: Pending"),
        ),
      );
    },
  );
}
