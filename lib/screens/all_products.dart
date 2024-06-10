import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/products_details_screen.dart';

enum SortOption { priceLowToHigh, priceHighToLow, ratingHighToLow }

extension SortOptionExtension on SortOption {
  String get name {
    switch (this) {
      case SortOption.priceLowToHigh:
        return 'Price: Low to High';
      case SortOption.priceHighToLow:
        return 'Price: High to Low';
      case SortOption.ratingHighToLow:
        return 'Rating: High to Low';
      default:
        return '';
    }
  }
}

class AllProducts extends StatefulWidget {
  const AllProducts({
    super.key,
  });

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              title: Text(SortOption.priceLowToHigh.name),
              onTap: () {
                _sortProducts(SortOption.priceLowToHigh);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(SortOption.priceHighToLow.name),
              onTap: () {
                _sortProducts(SortOption.priceHighToLow);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(SortOption.ratingHighToLow.name),
              onTap: () {
                _sortProducts(SortOption.ratingHighToLow);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _sortProducts(SortOption option) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    setState(() {
      switch (option) {
        case SortOption.priceLowToHigh:
          productsProvider.allProducts
              .sort((a, b) => a.price!.compareTo(b.price!));
          break;
        case SortOption.priceHighToLow:
          productsProvider.allProducts
              .sort((a, b) => b.price!.compareTo(a.price!));
          break;
        case SortOption.ratingHighToLow:
          productsProvider.allProducts
              .sort((a, b) => b.rating!.rate!.compareTo(a.rating!.rate!));
          break;
      }
    });
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              title: const Text('Price less than 100'),
              onTap: () {
                // _filterProducts(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Rating greater than 4'),
              onTap: () {
                // _filterProducts(2);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _filterProducts(int filterOption) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    setState(() {
      switch (filterOption) {
        case 1:
          productsProvider.allProducts
              .removeWhere((product) => product.price! >= 100);
          break;
        case 2:
          productsProvider.allProducts
              .removeWhere((product) => product.rating!.rate! <= 4);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _showSortOptions(context),
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text("Sort"), Icon(Icons.sort_rounded)],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => _showFilterOptions(context),
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Filter"),
                        Icon(Icons.filter_alt_outlined)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.555,
              ),
              itemCount: productsProvider.allProducts.length,
              itemBuilder: (context, index) {
                final products = productsProvider.allProducts[index];
                final isFavorite = productsProvider.isFavorite(products);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsDetailsScreen(
                          productId: products.id!,
                          product: products,
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
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(products.image!),
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
                                  products.title!,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  products.description!,
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\u20B9${products.price}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (isFavorite) {
                                            productsProvider
                                                .removeProductsFromFavorites(
                                                    products);
                                          } else {
                                            productsProvider
                                                .addProductsToFavorites(
                                                    products);
                                          }
                                        });
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
                                      "${products.rating?.rate ?? 0} (${products.rating?.count ?? 0}) reviews",
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
