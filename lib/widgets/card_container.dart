import 'package:flutter/material.dart';


class CardContainer extends StatelessWidget {
  final Widget child;
  
  const CardContainer({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Padding(      
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(    
        padding: EdgeInsets.all(20),    
        width: double.infinity,
        decoration: _createCardShape(),
        child: this.child
      
      
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
      color: Colors.black12,
      blurRadius: 15,
      offset: Offset(0, 5) //posición de la sombra de la tarjeta

      )

    ]
  );
}