import 'package:calista_ain/model/order_model.dart';
import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/user/admin/view_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService.getOrder(),
      builder: (context, snapshot) {
        List<ProductOrder>? orders = snapshot.data?.docs
            .map((e) => ProductOrder.fromJson(
                  e.data(),
                ))
            .toList();
        if (snapshot.hasData == false || orders == null) {
          return Center(
            child: SizedBox(
              height: Get.height,
              child: Image.asset(
                "images/no-orders.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            ProductOrder order = orders[index];
            if (order.status.toLowerCase() == "cancelled") return const SizedBox.shrink();
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Date: ${DateFormat().format(order.orderDate)}"),
                    Text("Status: ${order.status}"),
                    const SizedBox(height: 8),
                    ExpansionTile(
                      title: Text("View ${order.items.length} Item(s)"),
                      children: order.items.map((item) {
                        double discountPrice = item.price - item.price * item.discount ~/ 100;
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
                          subtitle: Text("Price: ৳ $discountPrice"
                              "\nQuantity: ${item.quantity}"),
                          trailing: Text(
                            "৳ ${discountPrice * item.quantity}",
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
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ViewOrder(), arguments: order);
                          },
                          child: const Text("View Details"),
                        ),
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
/***
    showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
    title: const Text("Tap yes to delete order"),
    actions: [
    TextButton(
    onPressed: () async {
    order.userId = "";
    bool response =
    await databaseService.placeOrder(order);
    if (response) {
    Get.showSnackbar(
    successSnackBar("Order deleted successfully"));
    } else {
    Get.showSnackbar(
    failedSnackBar("Something went wrong. Try again!"),
    );
    }
    Get.back();
    },
    child: const Text("Yes")),
    TextButton(
    onPressed: () {
    Get.back();
    },
    child: const Text("No"),
    ),
    ],
    );
    },
    );
 */
