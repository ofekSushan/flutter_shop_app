import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_providers.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/mainAppBar.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import '../widgets/products_item.dart';
import './edit_products.dart';
import '../providers/product.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> _refreshProducts(ctx) async {
    await Provider.of<Products>(ctx, listen: false).fetchAndSetProdcuts();
  }

  static const routeName = "/user-products";
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: MainAppBar(
        title: "Your Products",
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, index) => Column(
              children: [
                UserProductsItems(
                    id: productsData.items[index].id,
                    title: productsData.items[index].title,
                    imageUrl: productsData.items[index].imageUrl),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
