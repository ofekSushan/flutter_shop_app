import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/mainAppBar.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/orders";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

Future<void> _refreshProducts(ctx) async {
  Provider.of<Orders>(ctx, listen: false).fetchAndSetOrders();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;

  void initState() {
    _isLoading = true;
    Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: MainAppBar(
        title: "Your Cart",
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: (ctx, index) =>
                    OrderItemWid(order: ordersData.orders[index]),
              ),
            ),
    );
  }
}
