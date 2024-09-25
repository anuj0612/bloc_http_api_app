import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 160.0,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: 110.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: NetworkImage(product.thumbnail),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 12.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4.0),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 10.0),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
                const SizedBox(height: 2.0),
                Row(
                  children: List.generate(
                    product.rating.round(),
                    (int index) => const Icon(
                      Icons.star_rate,
                      size: 12.0,
                      color: Colors.amber,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
