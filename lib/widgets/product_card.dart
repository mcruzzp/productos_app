import 'package:flutter/material.dart';

import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {
  //const ProductCard({super.key});

  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(    
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(        
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),

            _ProductDetails(title: product.name, subTitle: product.id!),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(price: product.price)),

            if (!product.available)
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable())
          ],
        )
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(

    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      ),
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No Disponible',
          style: TextStyle(color: Colors.white, fontSize: 20))
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 163, 59),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      )
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\€$price', style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))


      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  final String subTitle;

  const _ProductDetails({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        //color: Colors.indigo,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('Disco duro G', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            Text(title, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis
          ),
          
          //Text('ID del disco duro', style: TextStyle(fontSize: 15, color: Colors.white),
          Text(subTitle, style: TextStyle(fontSize: 15, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis
          ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child:  url == null
          ? Image(image: AssetImage('assets/no-image.png'),
                  fit: BoxFit.cover)
          : FadeInImage(
              //image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
              image: NetworkImage(url!),
              placeholder: const AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.cover),
      ),
    );
  }
}