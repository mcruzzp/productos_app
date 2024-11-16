import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';





class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

     print('hola1');
     final productsService = Provider.of<ProductsService>(context);
     print('hola2');


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Productos',
            style: TextStyle(color: Colors.white),),
        )
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ( BuildContext context , int index) => GestureDetector(          
          onTap: () => Navigator.pushNamed(context, 'product'),
          child: ProductCard(),)//Text('Item $index')
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: (){},
        ),
    );
  }
}