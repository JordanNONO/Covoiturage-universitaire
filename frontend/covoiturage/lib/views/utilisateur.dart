import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'navbar.dart';



class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();

  Future<void> _registerUser() async {
    try {
      final response = await http.post(
        Uri.parse(AppServer.UTILISATEUR), // Replace with your API endpoint
        headers: AppServer.headers,
        body: jsonEncode({
          'nom': _nomController.text,
          'prenom': _prenomController.text,
          'adresse': _adresseController.text,
          'email': '${_nomController.text}@example.com', // Use name as base for email
          'password': 'password', // Consider generating a secure password
        }),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => NavBar()));
      } else {
        // Handle error response
        print('Error during registration: ${response.body}');
        // Show error message to the user
        _showErrorSnackBar('Registration failed. Please try again.');
      }
    } catch (e) {
      print('Error during registration: $e');
      _showErrorSnackBar('An error occurred. Please try again.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _prenomController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _adresseController,
              decoration: InputDecoration(labelText: 'Adresse'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Inscription'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Bienvenue sur la page d\'accueil !'),
      ),
    );
  }
}