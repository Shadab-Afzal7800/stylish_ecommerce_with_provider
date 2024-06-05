import 'package:flutter/material.dart';

import 'package:stylish_flutter/models/products_model.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final ProductsModel product;

  final int productId;
  const ProductsDetailsScreen({
    Key? key,
    required this.product,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.trolley),
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
              SizedBox(
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
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Icon(Icons.favorite_border)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Vision Alta Men’s Shoes Size (All Colours)"),
              Row(
                children: [
                  Icon(Icons.star),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.product.rating?.rate ?? 0} (${widget.product.rating?.count ?? 0}) reviews",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Price: \u20B9${widget.product.price.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Text(
                "Product Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text("${widget.product.description!}"),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/images/buy-now-button.png")),
                  GestureDetector(
                      onTap: () {},
                      child:
                          Image.asset("assets/images/go-to-cart-button.png")),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset("assets/images/Group 33819.png"),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset("assets/images/Group 33820.png")
            ],
          ),
        ),
      )),
    );
  }
}
