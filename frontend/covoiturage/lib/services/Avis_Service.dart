import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/server.dart';
import '../models/Avis.dart';

class AvisService {
  Future<List<Avis>> getAllAvis() async {
    final response = await http.get(Uri.parse(AppServer.AVIS));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Avis.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des avis");
    }
  }

  Future<Avis> saveAvis(Avis avis) async {
    final response = await http.post(
      Uri.parse(AppServer.AVIS),
      body: jsonEncode(avis.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Avis.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout de l'avis");
    }
  }

  Future<Avis> updateAvis(String avisId, Avis avis) async {
    final response = await http.put(
      Uri.parse("${AppServer.AVIS}/$avisId"),
      body: jsonEncode(avis.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Avis.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour de l'avis");
    }
  }

  Future<void> deleteAvis(String aviId) async {
    final response = await http.delete(Uri.parse("${AppServer.AVIS}/$aviId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression de l'avis");
    }
  }
}