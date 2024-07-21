import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/login_form_provider.dart';
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

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm())
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

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,


        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com', 
                labelText: 'Correo electrónico', 
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value)  => loginForm.email = value,
              validator: ( value ) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Formato de correo incorrecto.';

              },
            ),


            SizedBox(height: 30,),
            
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****', 
                labelText: 'Contraseña', 
                prefixIcon: Icons.lock_clock_sharp
              ),
              onChanged: (value)  => loginForm.password = value,
              validator: ( value ) {
                if (value != null && value.length >= 6) return null;

                return 'La longitud debe ser de 6 caracteres';

              },
            ),

            SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                  ? 'Espere...'
                  : 'Aceptar'
                  )
                ), 
              textColor: Colors.white,

              onPressed: loginForm.isLoading ? null :  () async {
                FocusScope.of(context).unfocus(); //Esconde el teclado

                if (!loginForm.isValidForm() ) return;
                
                loginForm.isLoading = true;

                await Future.delayed(Duration(seconds: 2)); //simulamos estado de espera para ver el texto "Esspere..." antes de nager al home

                loginForm.isLoading = true;

                Navigator.pushReplacementNamed(context, 'home');
              })
          ],),)
    );
  }
}