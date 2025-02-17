import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/services/storage_service.dart';
import 'package:calista_ain/user/admin/admin_home.dart';
import 'package:calista_ain/utilities/image_handling.dart';
import 'package:calista_ain/utilities/validation.dart';
import 'package:calista_ain/widgets/outlineButton.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  DatabaseService databaseService = DatabaseService();
  StorageService storageService = StorageService();
  List<File>? images;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  ProductModel? productModel = Get.arguments;

  @override
  void initState() {
    extractOldData();
    super.initState();
  }

  extractOldData() async {
    if (productModel != null) {
      try {
        nameController.text = productModel!.name!;
        descriptionController.text = productModel!.description!;
        priceController.text = productModel!.price!.toString();
        categoryController.text = productModel!.category!;
        discountController.text = productModel!.discount!.toString();
        stockController.text = productModel!.stockQuantity!.toString();
        // images =productModel!.images!.map((e) async => await toFile(e)).cast<File>().toList();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  void updateProduct() async {
    setState(() {
      isLoading = true;
    });
    StorageService storageService = StorageService();
    DatabaseService databaseService = DatabaseService();
    if (images != null) {
      List<String> imageUrl = await storageService.uploadImages(
        images!,
        productModel?.id ?? const Uuid().v4(),
      );
      for (String url in imageUrl) {
        productModel?.images?.add(url);
      }
    }

    ProductModel updatedProductModel = ProductModel(
      id: productModel?.id,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: double.tryParse(priceController.text.trim()),
      category: categoryController.text.trim(),
      stockQuantity: int.tryParse(stockController.text.trim()),
      discount: double.tryParse(discountController.text.trim()),
      images: productModel?.images ?? [],
      favourite: productModel?.favourite ?? [],
      cart: productModel?.cart ?? [],
    );

    bool response = await databaseService.addProduct(updatedProductModel);
    if (response == true) {
      Get.showSnackbar(successSnackBar("Product Updated Successfully"));
      Get.off(() => const AdminHomePage());
    } else {
      Get.showSnackbar(failedSnackBar("Something went wrong. Try again!"));
    }
    setState(() {
      isLoading = false;
    });
  }

  void deleteProduct() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure to delete ${productModel?.name}"),
          actions: [
            TextButton(
              onPressed: () async {
                bool response = await databaseService.deleteProduct(productModel?.id ?? "");
                if (response == true) {
                  Get.back();
                  Get.showSnackbar(successSnackBar("Product Deleted Successfully"));
                  Get.off(() => const AdminHomePage());
                } else {
                  Get.showSnackbar(failedSnackBar("Something went wrong. Try again!"));
                }
              },
              child: const Text("YES"),
            ),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("NO")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Product"),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (productModel?.images != null)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productModel?.images?.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(border: Border.all()),
                                    child: CachedNetworkImage(
                                      imageUrl: productModel!.images![index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      productModel?.images?.removeAt(index);
                                      if (productModel!.images!.isEmpty) {
                                        productModel?.images = [];
                                      }
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.cancel, color: Colors.red),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      if (images != null)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images?.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(border: Border.all()),
                                    child: Image(
                                      image: FileImage(images![index]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      images?.removeAt(index);
                                      if (images!.isEmpty) {
                                        images = null;
                                      }
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.cancel, color: Colors.red),
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      else
                        TextButton.icon(
                          icon: const Icon(Icons.add_circle_outline),
                          label: const Text("Add Product Images"),
                          onPressed: () async {
                            images = await ImageHandling.pickImages();
                            setState(() {});
                          },
                        ),
                      customFormField(
                        nameController,
                        "Product Title",
                        Icons.propane_tank_outlined,
                        TextInputType.text,
                        1,
                        textValidation,
                      ),
                      customFormField(
                        descriptionController,
                        "Product Description",
                        Icons.description_outlined,
                        TextInputType.text,
                        null,
                        textValidation,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: customFormField(
                              priceController,
                              "Price",
                              Icons.price_change_outlined,
                              TextInputType.number,
                              1,
                              amountValidation,
                            ),
                          ),
                          Expanded(
                            child: customFormField(
                              categoryController,
                              "Category",
                              Icons.category_outlined,
                              TextInputType.text,
                              1,
                              textValidation,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: customFormField(
                              stockController,
                              "Stock",
                              Icons.numbers_sharp,
                              TextInputType.number,
                              1,
                              amountValidation,
                            ),
                          ),
                          Expanded(
                            child: customFormField(
                              discountController,
                              "Discount %",
                              Icons.discount,
                              TextInputType.number,
                              1,
                              amountValidation,
                            ),
                          ),
                        ],
                      ),
                      outlineButton(
                        "Update Product",
                        () {
                          if (formKey.currentState!.validate() &&
                              (productModel?.images != null || images != null)) {
                            updateProduct();
                          } else {
                            Get.showSnackbar(failedSnackBar("Please add images & necessary info"));
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      outlineButton(
                        "Delete Product",
                        () {
                          deleteProduct();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
