import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';
import '../widgets/mainAppBar.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: MainAppBar(title: "Your Cart"),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount().toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.green),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.ChosenItems.values.toList(), cart.totalAmount());
                          cart.ClearCart();
                        }, 
                        child: const Text(
                          "Order Now",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cart.ChosenItems.length,
              itemBuilder: (ctx, index) => CartItemWId(
                id: cart.ChosenItems.values.toList()[index].id,
                productId: cart.ChosenItems.keys.toList()[index],
                price: cart.ChosenItems.values.toList()[index].price,
                quantity: cart.ChosenItems.values.toList()[index].quantity,
                title: cart.ChosenItems.values.toList()[index].title,
              ),
            ))
          ],
        ));
  }
}
