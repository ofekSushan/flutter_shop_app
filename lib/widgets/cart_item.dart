import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemWId extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemWId(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: ((direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are You Sure"),
                  content: Text("Do your want to remove ${title}"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text("No")),
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text("Yes")),
                  ],
                ));
      }),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Text(
          "Remove",
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(child: FittedBox(child: Text("\$${price}"))),
            title: Text(title),
            subtitle: Text("Total:\$${price * quantity}"),
            trailing: Text('${quantity}X'),
          ),
        ),
      ),
    );
  }
}
