class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? 'General',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      image: map['image'] ?? '', // Default empty string or placeholder
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
