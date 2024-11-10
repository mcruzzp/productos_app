import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {

final String _baseUrl = 'flutter-varios-c2850-default-rtdb.europe-west1.firebasedatabase.app';
final List<Product> products = [];

bool isLoading = true;

ProductService () {
  this.loadProducts();

}

Future<List<Product>> loadProducts () async {

  this.isLoading = true;
  notifyListeners();
  
  final url = Uri.https(_baseUrl, 'productos.json');
  final resp = await http.get(url);

  final Map<String, dynamic> productsMap = json.decode(resp.body);

  //recorremos la respuesta para convertirla en una lista
  productsMap.forEach((key, value) {
    final tempProduct = Product.fromMap(value);
    tempProduct.id = key;

    this.products.add(tempProduct);        

  });

  //this.isLoading = false;
  notifyListeners();

  return products;


}

}