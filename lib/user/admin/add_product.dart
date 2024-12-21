import 'dart:io';

import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/services/storage_service.dart';
import 'package:calista_ain/utilities/image_handling.dart';
import 'package:calista_ain/utilities/validation.dart';
import 'package:calista_ain/widgets/outlineButton.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  List<File>? images;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void addProduct() async {
    setState(() {
      isLoading = true;
    });
    StorageService storageService = StorageService();
    DatabaseService databaseService = DatabaseService();
    String id = const Uuid().v4();
    List<String> imageUrl = await storageService.uploadImages(images!, id);
    ProductModel productModel = ProductModel(
      id: id,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: double.tryParse(priceController.text.trim()),
      category: categoryController.text.trim(),
      stockQuantity: int.tryParse(stockController.text.trim()),
      discount: double.tryParse(discountController.text.trim()),
      images: imageUrl,
      favourite: [],
      cart: [],
    );

    bool response = await databaseService.addProduct(productModel);
    if (response == true) {
      Get.showSnackbar(successSnackBar("Product Added Successfully"));
    } else {
      Get.showSnackbar(failedSnackBar("Something went wrong. Try again!"));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (images == null)
                    TextButton.icon(
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text("Add Product Images"),
                      onPressed: () async {
                        images = await ImageHandling.pickImages();
                        setState(() {});
                      },
                    )
                  else
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images?.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
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
                              ),
                            ],
                          );
                        },
                      ),
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
                      Flexible(
                        flex: 4,
                        child: customFormField(
                          priceController,
                          "Price",
                          Icons.price_change_outlined,
                          TextInputType.number,
                          1,
                          amountValidation,
                        ),
                      ),
                      Flexible(
                        flex: 6,
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
                      Flexible(
                        flex: 4,
                        child: customFormField(
                          stockController,
                          "Stock",
                          Icons.numbers_sharp,
                          TextInputType.number,
                          1,
                          amountValidation,
                        ),
                      ),
                      Flexible(
                        flex: 6,
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
                    "Add Product",
                    () {
                      if (formKey.currentState!.validate() && images != null) {
                        addProduct();
                      } else {
                        Get.showSnackbar(failedSnackBar("Please add images & necessary info"));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
