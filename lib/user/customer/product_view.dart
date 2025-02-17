import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/widgets/custom_appbar.dart';
import 'package:calista_ain/widgets/product_images.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  DatabaseService databaseService = DatabaseService();
  String userID = FirebaseAuth.instance.currentUser!.uid;
  ProductModel product = Get.arguments;
  int star = 0;

  @override
  Widget build(BuildContext context) {
    print("Products Favourite List ${product.favourite}");
    print("MY USER ID $userID");
    double discountPercent = (100 - product.discount!) / 100;
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.size.height * 0.4,
                child: productImages(product.images),
              ),
              Text(
                "${product.name}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.pink),
              ),
              if (product.discount == 0)
                Text(
                  "৳ ${product.price} Only",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "৳ ${product.price} Only",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.pink,
                          ),
                    ),
                    Text(
                      "৳ ${(product.price! * discountPercent).ceilToDouble()} Only on ${product.discount}% Discount",
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.pink),
                    ),
                  ],
                ),
              // const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.width * 0.45,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (product.cart!.contains(userID)) {
                          product.cart!.remove(userID);
                        } else {
                          product.cart!.add(userID);
                        }
                        bool response = await databaseService.addProduct(product);
                        if (response) {
                          Get.showSnackbar(successSnackBar("Product added to the Cart"));
                        } else {
                          Get.showSnackbar(successSnackBar("Something went wrong"));
                        }
                        setState(() {});
                      },
                      label: product.cart!.contains(userID)
                          ? Text(
                              "Drop from Cart",
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          : Text(
                              "Add to Cart",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                      icon: product.cart!.contains(userID)
                          ? const Icon(Icons.remove_circle_outline)
                          : const Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.45,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (product.favourite!.contains(userID)) {
                          product.favourite!.remove(userID);
                        } else {
                          product.favourite!.add(userID);
                        }
                        bool response = await databaseService.addProduct(product);
                        if (response) {
                          Get.showSnackbar(successSnackBar("Product added to the Cart"));
                        } else {
                          Get.showSnackbar(successSnackBar("Something went wrong"));
                        }
                        setState(() {});
                      },
                      label: product.favourite!.contains(userID)
                          ? Text(
                              "Drop from Wishlist",
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          : Text(
                              "Add to Wishlist",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                      icon: product.favourite!.contains(userID)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline),
                    ),
                  ),
                ],
              ),
              // const Divider(),
              // Row(
              //   children: [
              //     const Text("Provide Rating: "),
              //     FivePointedStar(
              //       onChange: (count) {
              //         setState(() {
              //         });
              //       },
              //       count: 5,
              //       // size: Size(50, 20),
              //       selectedColor: Colors.pink,
              //     ),
              //   ],
              // ),
              const Divider(),

              const Text("Product Description: "),
              Text(
                "${product.description}",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
