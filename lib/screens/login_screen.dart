import 'package:flutter/material.dart';

import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgouround(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200),
              
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium,),
                    
                    SizedBox(height: 30,),

                    Text('Formulario')

                  ],)
              ),



            ],)
        )
      )
    );
  }
}