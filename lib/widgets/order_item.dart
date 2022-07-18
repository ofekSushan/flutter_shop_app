import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItemWid extends StatefulWidget {
  final OrderItem order;

  OrderItemWid({required this.order});

  @override
  State<OrderItemWid> createState() => _OrderItemWidState();
}

class _OrderItemWidState extends State<OrderItemWid> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount}"),
            subtitle:
                Text(DateFormat("dd/MM/yyyy").format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if (expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 50, 180),
              child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (ctx, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.order.products[index].title,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "${widget.order.products[index].quantity}X  \$${widget.order.products[index].price}")
                        ],
                      )),
            )
        ],
      ),
    );
  }
}
