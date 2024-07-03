import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_flutter/provider/category_provider.dart';
import 'package:stylish_flutter/view/category_wise_products.dart';

class CategoryWdiget extends StatefulWidget {
  const CategoryWdiget({super.key});

  @override
  State<CategoryWdiget> createState() => _CategoryWdigetState();
}

class _CategoryWdigetState extends State<CategoryWdiget> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    log("Category Widget");
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryProvider.categories.length,
          itemBuilder: (context, index) {
            final category = categoryProvider.categories[index];
            log("only this");
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryWiseProductsScreen(
                            category: category['name']!)));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(category['image']!),
                    ),
                    Text(category['name']!)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
