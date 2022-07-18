import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/mainAppBar.dart';

class AppDrawer extends StatelessWidget {
  List<Widget> buildListtTile(
      String title, IconData icon, VoidCallback taphandler) {
    return [
      Divider(),
      ListTile(
        leading: Icon(
          icon,
          size: 20,
        ),
        title: Text(title),
        onTap: taphandler,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          MainAppBar(
            title: "test",
            implyLeading: false,
          ),
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Text(
              "Best Shop",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          ...buildListtTile(
            "Shop",
            Icons.shop,
            () => Navigator.of(context).pushReplacementNamed("/"),
          ),
          ...buildListtTile(
            "Orders",
            Icons.shopping_cart,
            () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routeName),
          )
        ],
      ),
    );
  }
}
