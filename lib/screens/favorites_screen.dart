import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/products_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductsProvider>(context, listen: false).fetchFavorite());
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final favoriteProducts = productsProvider.favoriteProducts;
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 238, 237, 237),
        body: favoriteProducts.isEmpty
            ? Center(
                child: Text("No Favorites yet!"),
              )
            : ListView.builder(
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      shadowColor: Color(0xffF83758),
                      elevation: 10,
                      child: ListTile(
                        leading: Image.network(
                          product.image!,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title!),
                        subtitle: Text("\u20B9${product.price}"),
                        trailing: IconButton(
                            onPressed: () {
                              productsProvider
                                  .removeProductsFromFavorites(product);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsDetailsScreen(
                                      product: product,
                                      productId: product.id!)));
                        },
                      ),
                    ),
                  );
                }));
  }
}
