import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Trajet.dart';

class TrajetService {
  Future<List<Trajet>> getAll() async {
    final response = await http.get(Uri.parse(AppServer.TRAJET));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Trajet.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des trajets");
    }
  }

  Future<Trajet> save(Trajet trajet) async {
    final response = await http.post(
      Uri.parse(AppServer.TRAJET),
      body: jsonEncode(trajet.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Trajet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout du trajet");
    }
  }

  Future<Trajet> update(int trajetId, Trajet trajet) async {
    final response = await http.put(
      Uri.parse("${AppServer.TRAJET}/$trajetId"),
      body: jsonEncode(trajet.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Trajet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour du trajet");
    }
  }

  Future<void> delete(int trajetId) async {
    final response = await http.delete(Uri.parse("${AppServer.TRAJET}/$trajetId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression du trajet");
    }
  }
}