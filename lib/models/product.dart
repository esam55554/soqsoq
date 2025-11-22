class Product {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
     this.imageUrl,
    required this.price,
  });

  // Factory constructor to create a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'] is String ? double.parse(json['price']) : json['price'],
    );
  }

  // Method to convert Product to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
