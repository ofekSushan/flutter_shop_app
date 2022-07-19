import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get ChosenItems {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double totalAmount() {
    var total = 0.0;
    _items.forEach((key, oneCartItem) {
      total += oneCartItem.price * oneCartItem.quantity;
    });

    return total;
  }

  void UndoProduct(String ProductID) {
    if (!_items.containsKey(ProductID)) {
      return;
    }
    // אם המוצר נמצא פעמים ואני מוחק רק אחד
    if (_items[ProductID]!.quantity > 1) {
      _items.update(
          ProductID,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    }

    if (_items[ProductID]!.quantity == 1) {
      _items.remove(ProductID);
    }
    notifyListeners();
  }

  void addItem({
    required String productId,
    required String title,
    required double price,
  }) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void ClearCart() {
    _items = {};
    notifyListeners();
  }
}
