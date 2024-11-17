import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {

final String _baseUrl = 'flutter-varios-c2850-default-rtdb.europe-west1.firebasedatabase.app';
final List<Product> products = [];
late Product selectedProduct;

bool isLoading = true;
bool isSaving = false;



ProductsService () {
  loadProducts();

}

Future<List<Product>> loadProducts () async {

  this.isLoading = true;
  notifyListeners();

  
  final url = Uri.https(_baseUrl, 'productos.json');
  print(url);
  final resp = await http.get(url);

  final Map<String, dynamic> productsMap = json.decode(resp.body);

  print(productsMap);

  //recorremos la respuesta para convertirla en una lista
  productsMap.forEach((key, value) {
    final tempProduct = Product.fromMap(value);
    tempProduct.id = key;

    this.products.add(tempProduct);        

  });

  this.isLoading = false;
  notifyListeners();

  return products;


  }

  Future saveOrCreateProduct(product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //creacion
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();

  }


  Future<String> updateProduct (Product product) async {
    final url = Uri.https(_baseUrl, 'productos/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());

    final decodedData = resp.body;

    //refrescamos los datos del producto en la lista
    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    notifyListeners();
    
    return product.id!;
  }

}