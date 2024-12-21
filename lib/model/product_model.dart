class ProductModel {
  String? id;
  String? name;
  String? description;
  double? price;
  String? category;
  int? stockQuantity;
  double? discount;
  List<String>? images;
  List<String>? favourite;
  List<String>? cart;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.stockQuantity,
    this.discount,
    this.images,
    this.favourite,
    this.cart,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'] * 1.0,
        category: json['category'],
        stockQuantity: json['stockQuantity'],
        discount: json['discount'] * 1.0,
        images: json['images'] != null ? List<String>.from(json['images']) : null,
        favourite: json['favourite'] != null ? List<String>.from(json['favourite']) : null,
        cart: json['cart'] != null ? List<String>.from(json['cart']) : null,
      );
    } catch (e) {
      throw FormatException('Error deserializing Product: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'stockQuantity': stockQuantity,
      'discount': discount,
      'images': images,
      'favourite': favourite,
      'cart': cart,
    };
  }
}
