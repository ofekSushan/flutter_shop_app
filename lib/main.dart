import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/products_detail_screen.dart';
import 'screens/products_overview_screen.dart';
import './providers/products_providers.dart';
import 'package:provider/provider.dart';
import './screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(value: Orders())
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Colors.red,
          brightness: Brightness.dark,
          useMaterial3: true,
          fontFamily: "Raleway",
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: "RobotoCondensed",
              fontSize: 30,
            ),
          ),
        ),
        routes: {
          // שאתה רושם / זה אוטמטית מתחיל את האפלקציה  בעמוד הזה
          '/': ((ctx) => ProductsOverview()),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: ((context) => CartScreen()),
          OrderScreen.routeName: ((context) => OrderScreen()),
        },
      ),
    );
  }
}
