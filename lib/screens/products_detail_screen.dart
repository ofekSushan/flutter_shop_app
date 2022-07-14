import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../providers/products_providers.dart';

class ProductsDetail extends StatelessWidget {
  static const routeName = '/products-detail';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findbyid(productID);

    final appbar = AppBar(
      title: Text(
        loadedProduct.title,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );

    return Scaffold(
      appBar: appbar,
    );
  }
}
