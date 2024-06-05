import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  final List<Map<String, String>> _categories = [
    {'name': "women's clothing", 'image': 'assets/images/womens-clothing.jpg'},
    {'name': "men's clothing", 'image': 'assets/images/mens-clothing.jpg'},
    {'name': "jewelery", 'image': 'assets/images/jewelery.jpg'},
    {'name': "electronics", 'image': 'assets/images/electronics.jpg'},
  ];
  List<Map<String, String>> get categories => _categories;
}
