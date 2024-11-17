import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';


class ProductFormPovider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey  = GlobalKey<FormState>();

  late Product product;

  ProductFormPovider(this.product);

  updateAvailibility (bool value) {
    print(value);

    this.product.available = value;

    notifyListeners();

  }

  bool isValidForm () {
    
    return formKey.currentState?.validate() ?? false;
  }

}