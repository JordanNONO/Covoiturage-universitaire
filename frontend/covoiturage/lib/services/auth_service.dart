import 'dart:convert';
import 'dart:typed_data';
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
      return 1; // Login successful
    } else {
      final errorMessage = jsonDecode(response.body)['error'] ?? 'Unknown login error';
      print('Login error: $errorMessage');
      return 0; // Login failed
    }
  }

  Future<int> register(String nom, String prenom, String email, String password, String phone, Uint8List? photoData) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(AppServer.UTILISATEUR));

      // Add required fields
      request.fields['nom'] = nom;
      request.fields['prenom'] = prenom;
      request.fields['email'] = email;
      request.fields['motDePasse'] = password;
      request.fields['telephone'] = phone;

      // Add photo if it exists
      if (photoData != null) {
        request.files.add(http.MultipartFile.fromBytes('photoProfil', photoData, filename: 'photo.jpg'));
      }

      // Send the request
      final response = await request.send();
      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', nom);
        await prefs.setBool('isLoggedIn', true);
        return 1; // Registration successful
      } else {
        final errorMessage = await response.stream.bytesToString();
        print('Registration error: $errorMessage');
        return 0; // Registration failed
      }
    } catch (e) {
      print('Error during registration: $e');
      return 0; // Registration failed
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored preferences
  }
}