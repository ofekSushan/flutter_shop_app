import 'package:flutter/material.dart';
import '../widgets/mainAppBar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        'Your Cart',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );

    return Scaffold(
      appBar: MainAppBar(
        title: "test",
        actions: [],
      ),
    );
  }
}
