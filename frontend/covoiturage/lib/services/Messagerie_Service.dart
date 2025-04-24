import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Messagerie.dart';

class MessagerieService {
  Future<List<Messagerie>> getAllMessages() async {
    final response = await http.get(Uri.parse(AppServer.MESSAGERIE));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Messagerie.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des messages");
    }
  }

  Future<Messagerie> saveMessage(Messagerie message) async {
    final response = await http.post(
      Uri.parse(AppServer.MESSAGERIE),
      body: jsonEncode(message.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Messagerie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout du message");
    }
  }

  Future<Messagerie> updateMessage(String messagerieId, Messagerie message) async {
    final response = await http.put(
      Uri.parse("${AppServer.MESSAGERIE}/$messagerieId"),
      body: jsonEncode(message.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Messagerie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour du message");
    }
  }

  Future<void> deleteMessage(String messagerieId) async {
    final response = await http.delete(Uri.parse("${AppServer.MESSAGERIE}/$messagerieId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression du message");
    }
  }
}