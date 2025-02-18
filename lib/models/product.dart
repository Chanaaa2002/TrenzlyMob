class Product {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final double price;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Product',
      categoryId: json['category_id'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      price: double.tryParse(json['price'].toString()) ?? 0.0,  // ✅ FIXED PRICE PARSING
      //images: json['images'] != null ? List<String>.from(json['images']) : [], // ✅ FIXED IMAGE PARSING
      images: (json['images'] != null && json['images'] is List) 
          ? List<String>.from(json['images'].whereType<String>())  // ✅ Ensure only Strings in the list
          : [],
    );
  }
}
