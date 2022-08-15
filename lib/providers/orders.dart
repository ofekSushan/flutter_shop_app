import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        Uri.https("flutter-c748c-default-rtdb.firebaseio.com", "/orders.json");
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];

    if (json.decode(response.body) == null) {
      _orders = [];
      notifyListeners();
      return;
    }
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((orderID, orderData) {
      loadedOrders.add(OrderItem(
          id: orderID,
          amount: orderData["amount"],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
          dateTime: DateTime.parse(orderData["datetime"])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    final url =
        Uri.https("flutter-c748c-default-rtdb.firebaseio.com", "/orders.json");
    final respone = await http.post(url,
        body: json.encode({
          "amount": total,
          "datetime": timestamp.toIso8601String(),
          "products": cartProducts
              .map((cp) => {
                    "id": cp.id,
                    "title": cp.title,
                    "quantity": cp.quantity,
                    "price": cp.price
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(respone.body)["name"],
            amount: total,
            products: cartProducts,
            dateTime: timestamp));
    notifyListeners();
  }

   Future<void> deleteOrder(String id) async {
    final url = Uri.https(
        "flutter-c748c-default-rtdb.firebaseio.com", "/orders/${id}.json");
    final existingProductIndex = _orders.indexWhere((prod) => prod.id == id);
    OrderItem? existingProduct = _orders[existingProductIndex];
    _orders.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _orders.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: 'Could not delete product.');
    }
    existingProduct = null;
  }
}
