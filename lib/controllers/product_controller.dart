import 'package:dio/dio.dart';
import '../models/product.dart';
import '../utils/config.dart';

class ProductController {
  final Dio dio = Dio();

  /// Convert relative image paths from API to full URLs
  String getFullImageUrl(String imagePath) {
    return "${Config.baseUrl}/$imagePath"; // Ensure full image URL
  }

  Future<List<Product>> fetchProducts() async {
    try {
      Response response = await dio.get("${Config.baseUrl}/products");

      if (response.statusCode == 200 && response.data != null) {
        final body = response.data;
        if (body['success'] == true && body['data'] is List) {
          final List<dynamic> data = body['data'];
          print("Parsed Products Count: ${data.length}");

          return data.map((json) {
            // Convert image paths to full URLs
            List<String> imageUrls = (json['images'] as List<dynamic>?)
                    ?.map((img) =>
                        img.toString()) // Use the URL provided by the response
                    .toList() ??
                [];

            return Product.fromJson({...json, 'images': imageUrls});
          }).toList();
        } else {
          print("Invalid API response format: ${response.data}");
          throw Exception("Invalid API response format");
        }
      } else {
        print("API Error: ${response.statusCode} - ${response.data}");
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
