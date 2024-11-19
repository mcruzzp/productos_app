import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAbB1HIyyvW3fwpPOL0wjAH5t4FLajn0Bs';

  final storage = new FlutterSecureStorage();

  // si este método devuelve algo es porque se ha producido un error.
  Future<String?> createUser(String email, String password) async {
    print(password);

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //si hemos recibido la clave idToken es porque la solicitud ha sido correcta.

      storage.write(key: 'token', value: decodedResp['idToken']);

      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  // si este método devuelve algo es porque se ha producido un error.
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //si hemos recibido la clake idToken es porque la solicitud ha sido correcta.

      storage.write(
          key: 'token',
          value: decodedResp['idToken']); //Almacenamiento seguro del token

      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    storage.delete(key: 'token');

    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
