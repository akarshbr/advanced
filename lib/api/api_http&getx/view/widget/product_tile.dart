import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class ProductTile extends StatelessWidget {
  final Products products;

  ProductTile(this.products);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 130,
            child: CachedNetworkImage(
              imageUrl: products.image!,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 5),
          Text(
            products.title!,
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("₹ ${(products.price! * 83.23).toStringAsFixed(2)}"),
              Text("${products.rating?.rate!}"),
            ],
          )
        ],
      ),
    );
  }
}
