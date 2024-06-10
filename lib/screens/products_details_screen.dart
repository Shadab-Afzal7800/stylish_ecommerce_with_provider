import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stylish_flutter/models/products_model.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/cart_screen.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final ProductsModel product;

  final int productId;
  const ProductsDetailsScreen({
    super.key,
    required this.product,
    required this.productId,
  });

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final isFavorite = productsProvider.isFavorite(widget.product);
    final isInCart = productsProvider.isInCart(widget.product);
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.product.image!)),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      widget.product.title!,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            productsProvider
                                .removeProductsFromFavorites(widget.product);
                          } else {
                            productsProvider
                                .addProductsToFavorites(widget.product);
                          }
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.star),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.product.rating?.rate ?? 0} (${widget.product.rating?.count ?? 0}) reviews",
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Price: \u20B9${widget.product.price.toString()}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Product Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(widget.product.description!),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/buy-now-button.png")),
                  GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Added to Cart"),
                          backgroundColor: Color(0xffF83758),
                          duration: Duration(seconds: 2),
                        ));
                        setState(() {
                          if (!isInCart) {
                            productsProvider.addProductToCart(widget.product);
                          }
                        });
                      },
                      child:
                          Image.asset("assets/images/go-to-cart-button.png")),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset("assets/images/Group 33819.png"),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
