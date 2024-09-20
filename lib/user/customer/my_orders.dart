import 'package:calista_ain/widgets/view_orders.dart';
import 'package:calista_ain/widgets/view_products.dart';
import 'package:flutter/material.dart';
class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return viewOrders();
  }
}
