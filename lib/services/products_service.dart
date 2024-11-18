import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {

final String _baseUrl = 'flutter-varios-c2850-default-rtdb.europe-west1.firebasedatabase.app';
final List<Product> products = [];
late Product selectedProduct;

final storage = new FlutterSecureStorage();

File? newPictureFile; 

bool isLoading = true;
bool isSaving = false;



ProductsService () {
  loadProducts();

}

Future<List<Product>> loadProducts () async {

  this.isLoading = true;
  notifyListeners();

  
  final url = Uri.https(_baseUrl, 'productos.json', {
    'auth': await storage.read(key: 'token') ?? ''
  });
  print(url);
  final resp = await http.get(url);

  final Map<String, dynamic> productsMap = json.decode(resp.body);

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
      await createProduct (product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();

  }


  Future<String> createProduct (Product product) async {
    final url = Uri.https(_baseUrl, 'productos.json', {
    'auth': await storage.read(key: 'token') ?? ''
  });
    final resp = await http.post(url, body: product.toJson());

    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    //refrescamos los datos del producto en la lista
    this.products.add(product); 


    //notifyListeners();
    
    return product.id!;
  }

  Future<String> updateProduct (Product product) async {
    final url = Uri.https(_baseUrl, 'productos/${product.id}.json', {
    'auth': await storage.read(key: 'token') ?? ''
  });
    final resp = await http.put(url, body: product.toJson());

    final decodedData = resp.body;

    //refrescamos los datos del producto en la lista
    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    notifyListeners();
    
    return product.id!;
  }


  void updateSelectedProductImage( String path) {
    
    this.selectedProduct.picture = path;

    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();


  }

  Future<String?> uploadImage () async {
    if (this.newPictureFile == null) return null;
    
    this.isSaving = true;

    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dra2ev8xv/image/upload?upload_preset=ml_default');

    final imageUploadRequest = http.MultipartRequest( 'POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201){
      print('Error al subir la imagen.');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;
    
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];

  }
}