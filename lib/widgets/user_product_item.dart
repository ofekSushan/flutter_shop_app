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
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Are You Sure"),
                          content: Text("Do your want to remove ${title}"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("No")),
                            TextButton(
                                onPressed: () {
                                  Provider.of<Products>(ctx, listen: false)
                                      .deleteProduct(id);
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Yes")),
                          ],
                        ));
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
