import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Productos',
          style: TextStyle(color: Colors.white),),
        )
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ( BuildContext context , int index) => ProductCard()//Text('Item $index')
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: (){},
        ),
    );
  }
}