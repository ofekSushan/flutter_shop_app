import 'package:flutter/material.dart';

class UserProductsItems extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductsItems({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing:
       Container(
        width: 100,
        child: 
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
