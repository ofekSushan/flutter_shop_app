import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/products_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: (() => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id)),
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
                      }),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  title: Text(
                    product.title,
                    textAlign: TextAlign.center,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.shopping_bag),
                    onPressed: () {
                      cart.addItem(
                          title: product.title,
                          price: product.price,
                          productId: product.id);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Added Item to cart",
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () {
                              cart.UndoProduct(product.id);
                            }),
                      ));
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ))),
        ));
  }
}
