import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/mainAppBar.dart';
import '../providers/theme.dart';
import 'package:provider/provider.dart';

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
    final themeChanger = Provider.of<ThemeChanger>(context);
    bool isLightmod = themeChanger.isLightmod(themeChanger.themeMode);
    return Drawer(
      child: Column(
        children: [
          MainAppBar(
            title: "test",
            implyLeading: false,
          ),
           FloatingActionButton(
                onPressed: () {
                  isLightmod
                      ? themeChanger.setTheme(ThemeMode.dark)
                      : themeChanger.setTheme(ThemeMode.light);
                },
                child: Icon(
                  isLightmod ? Icons.dark_mode : Icons.light_mode,
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
