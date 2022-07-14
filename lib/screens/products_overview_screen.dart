import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../providers/product.dart';
import '../providers/products_providers.dart';

enum filterOptins { Favorites, All }

class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool showFavoritesOnly=false;
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context,listen: false);

    final appbar = AppBar(
      title: Text(
        "title",
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (filterOptins selectedValue) {
            setState(() {
              
            if (selectedValue == filterOptins.Favorites) {
            showFavoritesOnly=true;
            } else {
            showFavoritesOnly=false;

            }
            });

          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text("Show Favorites"),
              value: filterOptins.Favorites,
            ),
            PopupMenuItem(
              child: Text("Show All"),
              value: filterOptins.All,
            ),
          ],
        )
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: productsGrid(showFavoritesOnly:showFavoritesOnly),
    );
  }
}
