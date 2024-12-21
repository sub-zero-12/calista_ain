class ProductOrder {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final String status;
  final String? shippingAddress;
  final String? transactionID;

  ProductOrder({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    this.shippingAddress,
    this.transactionID,
  });

  // Factory method to create an Order from JSON
  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
      totalAmount: json['totalAmount'],
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
      shippingAddress: json['shippingAddress'],
      transactionID: json['transactionID'],
    );
  }

  // Convert the Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
      'shippingAddress': shippingAddress,
      'transactionID': transactionID,
    };
  }
}

class OrderItem {
  String productId;
  String name;
  int quantity;
  double price;
  String thumbnail;

  OrderItem({
    required this.productId,
    required this.name,
    this.quantity = 0,
    required this.price,
    required this.thumbnail,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'thumbnail': thumbnail,
    };
  }
}

enum OrderStatus {
  pending,
  confirmed,
  shipped,
  delivered,
  cancelled,
}