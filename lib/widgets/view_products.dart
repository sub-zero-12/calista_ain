import 'package:cached_network_image/cached_network_image.dart';
import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/user/admin/update_product.dart';
import 'package:calista_ain/user/customer/product_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
Widget viewProducts(List<ProductModel> products) {
  User? currentUser = FirebaseAuth.instance.currentUser;
  return GridView.builder(
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (context, index) {
      ProductModel product = products[index];
      double discountPrice = product.price! - (product.price! * product.discount!/100).toInt();
      return InkWell(
        onTap: () {
          if (currentUser!.email == "calistaain@gmail.com") {
            Get.to(() => const UpdateProduct(), arguments: product);
          } else {
            Get.to(() => const ProductView(), arguments: product);
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: double.maxFinite,
                      fit: BoxFit.fill,
                      imageUrl: product.images!.first,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.cloud_download_outlined),
                    ),
                  ),
                ),
                Text(
                  "${product.name}",
                  overflow: TextOverflow.ellipsis,
                ),
                if (product.discount == 0)
                  Text(
                    "৳ ${product.price} Only",
                  )
                else
                  Row(
                    children: [
                      Text(
                        "৳ ${product.price}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.pink,
                            color: Colors.pink),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "৳ $discountPrice Only",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    },
  );
}
