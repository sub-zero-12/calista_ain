import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/widgets/view_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  DatabaseService databaseService = DatabaseService();
  String selectedCategory = "";
  List<String> categoryList = [];

  List<ProductModel> filter(List<ProductModel> products) {
    if (selectedCategory == "") {
      return products;
    }
    List<ProductModel> filteredProducts = [];
    for (ProductModel product in products) {
      if(product.category!.toUpperCase() == selectedCategory.toUpperCase()){
        filteredProducts.add(product);
      }
    }
    return filteredProducts;
  }

  void allCategory(List<ProductModel> products) {
    for(ProductModel product in products){
      if(categoryList.contains(product.category!)){
        continue;
      }
      categoryList.add(product.category!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products =
              snapshot.data!.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
          allCategory(products);
          products = filter(products);
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.06,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: OutlinedButton(
                        onPressed: () {
                          String oldValue = selectedCategory;
                          selectedCategory = categoryList[index];
                          if (selectedCategory == oldValue) selectedCategory = "";
                          setState(() {});
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: selectedCategory == categoryList[index]
                              ? Colors.pink.shade100
                              : Colors.transparent,
                        ),
                        child: Text(categoryList[index]),
                      ),
                    );

                  },
                ),
              ),
              Expanded(child: viewProducts(products)),
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
