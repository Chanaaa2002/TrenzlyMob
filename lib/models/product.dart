class Product {
  final String? id;
  final String? name;
  final String? categoryId;
  final double? price;
  final List<String>? images;

  Product({
    this.id,
    this.name,
    this.categoryId,
    this.price,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      categoryId: json['category_id'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      images: (json['images'] != null)
          ? List<String>.from(json['images'])
          : null,
    );
  }
}
