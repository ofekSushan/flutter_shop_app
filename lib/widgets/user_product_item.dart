import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import '../screens/edit_products.dart';
import 'package:provider/provider.dart';
import '../providers/products_providers.dart';

class UserProductsItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductsItems(
      {required this.title, required this.imageUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    final Scaffold = ScaffoldMessenger.of(context);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  Scaffold.showSnackBar(
                      SnackBar(content: Text("deleting failed")));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
