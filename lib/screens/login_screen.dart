import 'package:flutter/material.dart';

import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackgouround(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200),
              
              CardContainer(
                child: Text('Hola Mundo')
              ),



            ],)
        )
      )
    );
  }
}