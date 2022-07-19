import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './products_item.dart';
import '../providers/products_providers.dart';
import '../providers/product.dart';

class productsGrid extends StatelessWidget {
  bool showFavoritesOnly;

  productsGrid({required this.showFavoritesOnly});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> products;
    if (showFavoritesOnly) {
      products = productsData.favoriteItems;
    } else {
      products = productsData.items;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 30,
          mainAxisSpacing: 20),
    );
  }
}
