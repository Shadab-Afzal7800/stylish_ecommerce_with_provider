import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/products_details_screen.dart';

class CategoryWiseProductsScreen extends StatelessWidget {
  final String category;
  const CategoryWiseProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final categoryProdcuts = productsProvider.allProducts
        .where((product) => product.category == category)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.555),
          itemCount: categoryProdcuts.length,
          itemBuilder: (context, index) {
            final product = categoryProdcuts[index];
            final isFavorite = productsProvider.isFavorite(product);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductsDetailsScreen(
                            product: product, productId: product.id!)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(product.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.description!,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\u20B9${product.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      productsProvider
                                          .removeProductsFromFavorites(product);
                                    } else {
                                      productsProvider
                                          .addProductsToFavorites(product);
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.star),
                                const SizedBox(width: 5),
                                Text(
                                  "${product.rating?.rate ?? 0} (${product.rating?.count ?? 0}) reviews",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
