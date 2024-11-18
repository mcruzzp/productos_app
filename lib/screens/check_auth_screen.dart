import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              //si el snapshot no tiene datos (es decirt, si readToken devuelve nuelo)
              if (!snapshot.hasData) return Text('Espere');

              if (snapshot.data == ''){

              //Future builder espera devovler un Widget .
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginScreen(),
                          transitionDuration: Duration(seconds: 0)));
                  }
                );
              } else {
                                Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));
                }
              );

              }

              return Container();
            }),
      ),
    );
  }
}
