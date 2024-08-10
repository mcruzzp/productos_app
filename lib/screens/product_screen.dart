import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget { 
  const ProductScreen({super.key});

@override
Widget build(BuildContext context) {
  return  Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ProductImage(),

              Positioned(
                top: 50,
                left: 20,                
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 40),
                  )
                )
            ]
            )
          ],
        )

      )
    );    
  }
}