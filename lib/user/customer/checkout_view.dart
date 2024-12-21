import 'package:cached_network_image/cached_network_image.dart';
import 'package:calista_ain/model/order_model.dart';
import 'package:calista_ain/model/product_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/user/customer/customer_home.dart';
import 'package:calista_ain/user/customer/my_orders.dart';
import 'package:calista_ain/utilities/validation.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:calista_ain/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  DatabaseService databaseService = DatabaseService();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();

  bool CoD = false;
  bool pickUp = false;
  bool isLoading = false;

  double totalAmount = 0;
  List<ProductModel> cart = Get.arguments;
  List<OrderItem> orderItems = [];

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    orderItems = cart
        .map(
          (cartItem) => OrderItem(
            productId: cartItem.id ?? "",
            name: cartItem.name ?? "",
            quantity: 0,
            price: cartItem.price ?? 0,
            thumbnail: cartItem.images!.first,
          ),
        )
        .toList();
    super.initState();
  }

  placeOrder() async {
    setState(() {
      isLoading = true;
    });
    ProductOrder order = ProductOrder(
      id: const Uuid().v4(),
      userId: FirebaseAuth.instance.currentUser!.uid,
      items: orderItems,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      status: "Pending",
      shippingAddress: pickUp ? "Pick Up from Spot" : shippingAddressController.text.trim(),
      transactionID: CoD ? "Cash on Delivery" : transactionIdController.text.trim(),
    );
    bool response = await databaseService.placeOrder(order);
    setState(() {
      isLoading = false;
    });
    if (response) {
      Get.showSnackbar(successSnackBar("Order is placed successfully"));
    } else {
      Get.showSnackbar(failedSnackBar("Something went wrong try again!"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Page"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 6,
                          child: CheckboxListTile(
                            title: const Text("Cash on Delivery"),
                            //subtitle: const Text("Inside Sylhet: 40 TK | Outside Sylhet: 120 TK"),
                            value: CoD,
                            onChanged: (value) {
                              setState(() {
                                CoD = !CoD;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: CheckboxListTile(
                            title: const Text("Pick Up"),
                            // subtitle: const Text("Inside Sylhet: 40 TK | Outside Sylhet: 120 TK"),
                            value: pickUp,
                            onChanged: (value) {
                              setState(() {
                                pickUp = !pickUp;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (!pickUp)
                            customFormField(
                              shippingAddressController,
                              "Shipping Address",
                              CupertinoIcons.location,
                              TextInputType.text,
                              1,
                              textValidation,
                            ),
                          if (!CoD)
                            customFormField(
                              transactionIdController,
                              "Transaction ID",
                              CupertinoIcons.money_dollar,
                              TextInputType.text,
                              1,
                              textValidation,
                            ),
                        ],
                      ),
                    ),

                    CircleAvatar(
                      radius: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Total"),
                          Text("${totalAmount.toPrecision(2)}"),
                          InkWell(
                              child: const Text("Place Order"),
                              onTap: () {
                                if (formKey.currentState!.validate() && totalAmount > 0) {
                                  for(OrderItem order in orderItems){
                                    if(order.quantity == 0){
                                      orderItems.remove(order);
                                    }
                                  }
                                  placeOrder();
                                  Get.back();
                                } else {
                                  Get.showSnackbar(failedSnackBar(
                                      "Provide necessary info or add item to place order"));
                                }
                              })
                        ],
                      ),
                    ),
                    // const Text("BKash Number: 01912345678"),

                    ...orderItems.map((item) {
                      double itemPrice = item.price;
                      // (1 - ((cart[index].discount! / 100)).toPrecision(2));
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: item.thumbnail,
                          ),
                        ),
                        title: Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // subtitle: Text("$itemPrice"),
                        subtitle: SizedBox(
                          width: 120,
                          child: Row(
                            children: [
                              const Text("Quantity "),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  if (item.quantity >= 1) {
                                    item.quantity -= 1;
                                    totalAmount -= itemPrice;
                                  }
                                  setState(() {});
                                },
                                child: const Icon(Icons.remove),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${item.quantity}",
                                  style: TextStyle(
                                      fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  item.quantity += 1;
                                  totalAmount += itemPrice;
                                  setState(() {});
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
      ),
    );
  }
}
