import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {

final String _baseUrl = 'flutter-varios-c2850-default-rtdb.europe-west1.firebasedatabase.app';
final List<Product> products = [];

bool isLoading = true;

ProductService () {
  this.loadProducts();

}

Future<List<Product>> loadProducts () async {

}

}