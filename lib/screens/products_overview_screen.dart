import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/mainAppBar.dart';

// ignore: camel_case_types
enum filterOptins { Favorites, All }

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({Key? key}) : super(key: key);

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: MainAppBar(
        title: "Shop",
        actions: [
          PopupMenuButton(
            onSelected: (filterOptins selectedValue) {
              setState(() {
                if (selectedValue == filterOptins.Favorites) {
                  showFavoritesOnly = true;
                } else {
                  showFavoritesOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: filterOptins.Favorites,
                child: Text("Show Favorites"),
              ),
              const PopupMenuItem(
                value: filterOptins.All,
                child: Text("Show All"),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
                value: cartData.itemCount.toString(),
                color: Colors.red,
                child: ch!),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: productsGrid(showFavoritesOnly: showFavoritesOnly),
    );
  }
}
