import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_flutter/provider/products_provider.dart';
import 'package:stylish_flutter/screens/products_details_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductsProvider>(context, listen: false).fetchCart());
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProducts = productsProvider.cartProducts;
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 238, 237, 237),
        body: cartProducts.isEmpty
            ? Center(child: Text("Your Cart is empty!"))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Cart value",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "\u20B9${productsProvider.totalAmount.toStringAsFixed(0)}",
                          style: TextStyle(fontSize: 25, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final product = cartProducts[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              elevation: 10,
                              shadowColor: Color(0xffF83758),
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
                                          .removeProductsFromCart(product);
                                    },
                                    icon: Icon(Icons.delete)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductsDetailsScreen(
                                                  product: product,
                                                  productId: product.id!)));
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Material(
                        elevation: 10.0,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xffF83758),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Center(
                              child: Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
