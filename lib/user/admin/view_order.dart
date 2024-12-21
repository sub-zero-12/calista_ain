import 'package:cached_network_image/cached_network_image.dart';
import 'package:calista_ain/model/order_model.dart';
import 'package:calista_ain/model/user_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum OrderStatus {
  pending,
  confirmed,
  shipped,
  delivered,
  cancelled,
}

class ViewOrder extends StatefulWidget {
  const ViewOrder({Key? key}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  ProductOrder order = Get.arguments;
  DatabaseService databaseService = DatabaseService();
  String status = Get.arguments.status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserModel>(
          future: databaseService.getUserData(order.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError || snapshot.hasData == false) return const SizedBox.shrink();
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(),
                    const Text("User Details"),
                    const Divider(),
                    Text("Name: ${snapshot.data?.name}"),
                    Text("Email: ${snapshot.data?.email}"),
                    Text("Phone: ${snapshot.data?.number}"),
                    const Divider(),
                    const Text("Order Details"),
                    const Divider(),
                    Text("Delivery Address: ${order.shippingAddress}"),
                    Text("Transaction ID: ${order.transactionID}"),
                    Text("Order Status: ${order.status.capitalizeFirst}"),
                    Text("Sub-total: ${DateFormat().format(order.orderDate)}"),
                    Text("Sub-total: ${order.totalAmount}"),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              value: status,
                              items: const [
                                DropdownMenuItem(
                                  value: "Pending",
                                  child: Text("Pending"),
                                ),
                                DropdownMenuItem(
                                  value: "Confirmed",
                                  child: Text("Confirmed"),
                                ),
                                DropdownMenuItem(
                                  value: 'Shipped',
                                  child: Text("Shipped"),
                                ),
                                DropdownMenuItem(
                                  value: 'Delivered',
                                  child: Text("Delivered"),
                                ),
                                DropdownMenuItem(
                                  value: 'Cancelled',
                                  child: Text("Cancelled"),
                                ),
                              ],
                              onChanged: (val) {
                                status = val!;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              order.status = status;
                              bool response = await DatabaseService().placeOrder(order);
                              if (response) {
                                Get.showSnackbar(successSnackBar("Order Status Updated"));
                              } else {
                                Get.showSnackbar(failedSnackBar("Order Status Update"));
                              }
                              setState(() {});
                            },
                            child: const Text("Update Order Status"))
                      ],
                    ),
                    const Divider(),
                    const Text("Ordered Item(s)"),
                    const Divider(),
                    ...order.items
                        .map((item) => Card(
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: item.thumbnail,
                                  ),
                                ),
                                title: Text(item.name),
                                subtitle:
                                    Text("${item.price - (item.price * item.discount ~/ 100)}"),
                                trailing: Text("Quantity: ${item.quantity}"),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
