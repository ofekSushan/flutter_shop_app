import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/mainAppBar.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName="/orders"; 
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: MainAppBar(
        title: "Your Cart",
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, index) =>
            OrderItemWid(order: ordersData.orders[index]),
      ),
    );
  }
}
