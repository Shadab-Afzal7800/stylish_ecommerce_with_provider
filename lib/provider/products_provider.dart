import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/products_model.dart';
import 'package:stylish_flutter/services/api_services/products_api.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductsModel> _allProducts = [];
  List<ProductsModel> _favoriteProducts = [];
  List<ProductsModel> _cartProducts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductsModel> get allProducts => _allProducts;
  List<ProductsModel> get favoriteProducts => _favoriteProducts;
  List<ProductsModel> get cartProducts => _cartProducts;
  bool get isLoading => _isLoading;
  String? get erroeMessage => _errorMessage;
  double get totalAmount =>
      // ignore: avoid_types_as_parameter_names
      _cartProducts.fold(0, (sum, item) => sum + item.price!);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<ProductsModel> searchProducts(String query) {
    // Filter products based on search query
    return _allProducts
        .where((product) =>
            product.title != null &&
            product.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  ProductsProvider() {
    fetchProducts();
    _auth.authStateChanges().listen((user) {
      if (user != null) {}
    });
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

  Future<void> fetchFavorite() async {
    User? user = _auth.currentUser;
    if (user == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('users/${user.uid}/favorites').get();
      _favoriteProducts = snapshot.docs
          .map((doc) =>
              ProductsModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCart() async {
    User? user = _auth.currentUser;
    if (user == null) return;
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot =
          await _firestore.collection('users/${user.uid}/cart').get();
      _cartProducts = snapshot.docs
          .map((doc) =>
              ProductsModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addProductsToFavorites(ProductsModel product) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
      await _firestore
          .collection('users/${user.uid}/favorites')
          .add(product.toJson());
    }
  }

  void removeProductsFromFavorites(ProductsModel product) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
      notifyListeners();
      QuerySnapshot snapshot = await _firestore
          .collection('users/${user.uid}/favorites')
          .where('id', isEqualTo: product.id)
          .get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  bool isFavorite(ProductsModel product) {
    return _favoriteProducts.contains(product);
  }

  void addProductToCart(ProductsModel product) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    if (!_cartProducts.contains(product)) {
      _cartProducts.add(product);
      notifyListeners();
      await _firestore
          .collection('users/${user.uid}/cart')
          .add(product.toJson());
    }
  }

  void removeProductsFromCart(ProductsModel product) async {
    User? user = _auth.currentUser;
    if (user == null) return;
    if (_cartProducts.contains(product)) {
      _cartProducts.remove(product);
      notifyListeners();
      QuerySnapshot snapshot = await _firestore
          .collection('users/${user.uid}/cart')
          .where('id', isEqualTo: product.id)
          .get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  bool isInCart(ProductsModel product) {
    return _cartProducts.contains(product);
  }
}
