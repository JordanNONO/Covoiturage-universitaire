import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<int> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(AppServer.LOGIN),
      headers: AppServer.headers,
      body: jsonEncode({
        'nom': username,
        'motDePasse': password,
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setBool('isLoggedIn', true);
      return 1; // Connexion réussie
    } else {
      final errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur de connexion inconnue';
      print('Erreur de connexion: $errorMessage');
      return 0; // Échec de la connexion
    }
  }

  Future<int> register(String nom, String prenom, String email, String password, String phone, String photoProfil) async {
    final response = await http.post(
      Uri.parse(AppServer.UTILISATEUR), // Endpoint d'inscription
      headers: AppServer.headers,
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'motDePasse': password,
        'telephone': phone,
        'photoProfil': photoProfil,
      }),
    );

    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', nom);
      await prefs.setBool('isLoggedIn', true);
      return 1; // Inscription réussie
    } else {
      final errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur d\'inscription inconnue';
      print('Erreur d\'inscription: $errorMessage');
      return 0; // Échec de l'inscription
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}