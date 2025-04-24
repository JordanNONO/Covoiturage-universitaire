import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/server.dart';



class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Vérifiez le statut de connexion au démarrage
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  Future<void> login(String email, String motDePasse) async {
    final response = await http.post(
      Uri.parse("${AppServer.LOGIN}/$email"), // Remplacez par votre API
      headers: AppServer.headers,
      body: jsonEncode({'email': email, 'password': motDePasse}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() {
        isLoggedIn = true;
      });
    } else {
      // Gérer l'erreur de connexion
      print('Erreur de connexion: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //
    );
  }
}