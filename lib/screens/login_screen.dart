import 'package:flutter/material.dart';

import 'package:productos_app/ui/input_decorations.dart';
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
              Text('Crear un nueva cuenta', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 50,),



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
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(hintText: 'john.doe@gmail.com', labelText: 'Correo electrónico', prefixIcon: Icons.alternate_email_rounded),
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: '*****', labelText: 'Contraseña', prefixIcon: Icons.lock_clock_sharp),
            ),

            SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text('Aceptar')
                ), 
              textColor: Colors.white,

              onPressed:  (){})
          ],),)
    );
  }
}