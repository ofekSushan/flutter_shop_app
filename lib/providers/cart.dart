import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quanitity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quanitity,
      required this.price});
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String id, String title, double price) {
    // אם המוצר כבר נמצא ברשימה
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              quanitity: existingItem.quanitity + 1,
              price: existingItem.price));
    } else {
      // אם המוצר הזה חדש לרישה
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quanitity: 1,
              price: price));
    }
  }
}
