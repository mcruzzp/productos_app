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

                    _LoginForm()
                  ],)
              ),
              SizedBox(height: 50,),
              Text('Crear un nueva cuenta', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))



            ],)
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //TODO mantener la referencia al KEY
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2
                  )
                ),
                hintText: 'Correo electrónico',
                labelText: 'Correo',
                labelStyle: TextStyle(
                  color: Colors.grey
                ),
                prefixIcon: Icon(Icons.alternate_email_sharp, color: Colors.deepPurple)
              ),
            )
          ],),)
    );
  }
}