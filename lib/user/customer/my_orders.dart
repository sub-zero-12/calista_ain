import 'package:calista_ain/model/order_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().getCustomerOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) return const SizedBox();
        List<ProductOrder> orders =
            snapshot.data!.docs.map((e) => ProductOrder.fromJson(e.data())).toList();
        print(snapshot.data!.docs.first.data());
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            ProductOrder order = orders[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Date: ${DateFormat().format(order.orderDate)}"),
                    Text("Status: ${order.status} | TrxID: ${order.transactionID}"),
                    const SizedBox(height: 8),
                    ExpansionTile(
                      title: Text("View ${order.items.length} Item(s)"),
                      children: order.items.map((item) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              item.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item.name),
                          subtitle: Text("Price: ৳ ${item.price}\nQuantity: ${item.quantity}"),
                          trailing: Text(
                            "৳ ${item.price * item.quantity}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount: ৳ ${order.totalAmount}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        if (order.status.toLowerCase() == "pending")
                          IconButton(
                            onPressed: () {
                              Get.defaultDialog(title: "Tap yes to delete the order", actions: [
                                TextButton(onPressed: () {}, child: const Text("Yes")),
                                TextButton(onPressed: () {}, child: const Text("No")),
                              ]);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        if (order.status.toLowerCase() == "pending")
                          IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Tap yes to cancel the order",
                                actions: [
                                  TextButton(onPressed: () {}, child: const Text("Yes")),
                                  TextButton(onPressed: () {}, child: const Text("No")),
                                ],
                              );
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
