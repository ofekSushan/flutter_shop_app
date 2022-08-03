import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/mainAppBar.dart';
import '../providers/products_providers.dart';

// ignore: camel_case_types
enum filterOptins { Favorites, All }

class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProdcuts()
          .then((_) {
            setState(() {
              
        _isLoading = false;
            });
      });
      super.initState();
  }

  bool showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : productsGrid(showFavoritesOnly: showFavoritesOnly),
    );
  }
}
