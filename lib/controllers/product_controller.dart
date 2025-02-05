import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utils/config.dart';

class ProductController {
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('${Config.baseUrl}/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
