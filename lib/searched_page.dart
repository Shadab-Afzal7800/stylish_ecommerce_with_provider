import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/products_details_screen.dart';

class SearchedPage extends StatefulWidget {
  const SearchedPage({
    super.key,
  });

  @override
  State<SearchedPage> createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20),
                fillColor: Colors.white,
                // filled: true,
                prefixIcon: Icon(Icons.search_rounded),
                hintText: "Search any Product...",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer<ProductsProvider>(
              builder: (context, provider, _) {
                final products = provider.searchProducts(_searchQuery);
                if (_searchQuery.isEmpty) {
                  return const Center(
                    child: Text("Type to search"),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.555,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isFavorite = provider.isFavorite(product);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsDetailsScreen(
                                productId: product.id!,
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              setState(() {
                                                if (isFavorite) {
                                                  provider
                                                      .removeProductsFromFavorites(
                                                          product);
                                                } else {
                                                  provider
                                                      .addProductsToFavorites(
                                                          product);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFavorite
                                                  ? Colors.red
                                                  : null,
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
                                            style:
                                                const TextStyle(fontSize: 12),
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
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
