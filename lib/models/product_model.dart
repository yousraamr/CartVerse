class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String category;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'category': category,
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: (map['price'] as num).toDouble(),
      category: map['category'],
      description: map['description'],
    );
  }
  factory Product.fromJson(Map<String, dynamic> json) => Product.fromMap(json);
}
