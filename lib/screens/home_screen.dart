import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';





class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

     final productsService = Provider.of<ProductsService>(context);

     if( productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Productos',
            style: TextStyle(color: Colors.white),),
        )
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( BuildContext context , int index) => GestureDetector(          
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
              
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(
            product: productsService.products[index],
          ),)//Text('Item $index')
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: (){},
        ),
    );
  }
}