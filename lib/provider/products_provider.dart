import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/products_model.dart';
import 'package:stylish_flutter/services/api_services/products_api.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductsModel> _allProducts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductsModel> get allProducts => _allProducts;
  bool get isLoading => _isLoading;
  String? get erroeMessage => _errorMessage;

  ProductsProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      List<ProductsModel> products = await ProductsApi().fetchProductsApi();
      _allProducts = products;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
