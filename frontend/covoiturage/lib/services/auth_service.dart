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
      return 1;
    } else {
      print('Erreur de connexion' + response.statusCode.toString());
      return 0;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}