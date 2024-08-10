import 'package:flutter/material.dart';


class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: _bueldBoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)),
          child: const FadeInImage( 
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage('https://via.placeholder.com/400x300/green'),
            fit: BoxFit.cover,
          
          ),
        )
        ),
      

    );
  }

  BoxDecoration _bueldBoxDecoration() => BoxDecoration( 
    color: Colors.red,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [BoxShadow(
      color: Colors.black12.withOpacity(0.05),
      blurRadius: 10,
      offset: Offset(0,5)

      )]

  );
}