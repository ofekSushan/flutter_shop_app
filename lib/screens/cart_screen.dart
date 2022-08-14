import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';
import '../widgets/mainAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                    OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : TextButton(
            onPressed: () async {
              if (widget.cart.ChosenItems.isEmpty || isLoading) {
                Fluttertoast.showToast(
                    msg: "please add items brfore ordering",
                    textColor: Colors.red,
                    gravity: ToastGravity.CENTER);
                return;
              }
              setState(() {
                isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.ChosenItems.values.toList(),
                  widget.cart.totalAmount());
              setState(() {
                isLoading = false;
              });
              widget.cart.ClearCart();
              Fluttertoast.showToast(
                  msg: "order added",
                  textColor: Colors.green,
                  gravity: ToastGravity.CENTER);
            },
            child: const Text(
              "Order Now",
              style: TextStyle(color: Colors.red),
            ));
  }
}
