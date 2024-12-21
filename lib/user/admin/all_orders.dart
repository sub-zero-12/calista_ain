import 'package:calista_ain/services/db_service.dart';
import 'package:calista_ain/widgets/view_orders.dart';
import 'package:flutter/material.dart';
class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return viewOrders();
  }
}
