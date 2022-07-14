import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/products_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return
        // makes the gridtile circular
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
                child: Image.network(
                  product.imageUrl,
                  // takes size as big as it can get
                  fit: BoxFit.cover,
                ),
                footer: GridTileBar(
                    leading: IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        product.toggleFavorite();
                      }
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    title: Text(
                      product.title,
                      textAlign: TextAlign.center,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.shopping_bag),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            ProductsDetail.routeName,
                            arguments: product.id);
                      },
                      color: Theme.of(context).colorScheme.primary,
                    ))));
  }
}
