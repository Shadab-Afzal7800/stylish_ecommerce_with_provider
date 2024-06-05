import 'dart:convert';
import 'dart:developer';

import 'package:stylish_flutter/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:stylish_flutter/services/utilities/app_urls.dart';

class ProductsApi {
  Future<List<ProductsModel>> fetchProductsApi() async {
    try {
      final List<dynamic> data;
      final response = await http.get(Uri.parse(AppUrls.productsUrl));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        return data.map((json) => ProductsModel.fromJson(json)).toList();
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      log('Error: $e');
      throw Exception("Failed ot fetch data: $e");
    }
  }
}
