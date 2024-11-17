import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget { 
  
  const ProductScreen({super.key});

@override
Widget build(BuildContext context) {

  final productService = Provider.of<ProductsService>(context);

  //return  _ProductScreenBody(ProductService: ProductService);    
  return ChangeNotifierProvider(
    create: ( _ ) => ProductFormPovider(productService.selectedProduct!),
    child: _ProductScreenBody(ProductService: productService)
  );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.ProductService,
  });

  final ProductsService ProductService;

  @override
  Widget build(BuildContext context) {
   
    final productForm = Provider.of<ProductFormPovider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, //esconde el teclado al desplazar la pantalla
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url:ProductService.selectedProduct?.picture),
    
                Positioned(
                  top: 60,
                  left: 20,                
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 40),
                    )
                  ),
    
                Positioned(
                  top: 60,
                  right: 20,                
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 40),
                    onPressed: () async {
                      final picker = new ImagePicker();
                      //final PickedFile? pickedFile = await picker.pickImage(
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100
                      );

                      if(pickedFile == null) {
                        print('No se ha seleccionado o capturado imagen.');
                        return;
                      }

                      print('Tenemos Imagen!!!! ${pickedFile.path}');
                    },
                    )
                  )
                ]
              ),
              _ProductForm(),
    
              SizedBox(height: 100,)
            ],
          )
    
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save_outlined, color: Colors.white, size: 30),
          onPressed: () async {
            if (!productForm.isValidForm()) return;

            ProductService.saveOrCreateProduct(productForm.product);
          }),
      );
  }
}

class _ProductForm extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormPovider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(        
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
                
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1) 
                    return 'El nombre es obligatorio.';
                } ,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre Producto', 
                  labelText: 'Nombre: '                  
                ),
              ),

              SizedBox(height: 30,),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: 
                  [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                validator: (value) {
                  if (value == null || value.length < 1) 
                    return 'El precio es obligatorio.';
                } ,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\€150', 
                  labelText: 'Precio:'                  
                ),
              ),

              SizedBox(height: 30,),

              SwitchListTile.adaptive(
                value: product.available, 
                title: Text('Disponible'),
                onChanged: (value)  => productForm.updateAvailibility (value)
              ),


              SizedBox(height: 30),
                
            ],),),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
        color: Colors.black12.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5

      
      )]
    );
  }
}