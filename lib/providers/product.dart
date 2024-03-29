import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavorite() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url =
        Uri.https("flutter-c748c-default-rtdb.firebaseio.com", "/producs/$id.json");
    notifyListeners();
    try {
      final respone =
          await http.patch(url, body: json.encode({"isFavorite": isFavorite}));
      if (respone.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
