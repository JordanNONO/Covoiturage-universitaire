import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Vehicule.dart';

class VehiculeService {
  Future<List<Vehicule>> getAll() async {
    final response = await http.get(Uri.parse(AppServer.VEHICULE));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Vehicule.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des véhicules");
    }
  }

  Future<Vehicule> save(Vehicule vehicule) async {
    final response = await http.post(
      Uri.parse(AppServer.VEHICULE),
      body: jsonEncode(vehicule.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Vehicule.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout du véhicule");
    }
  }

  Future<Vehicule> update(String vehiculeId, Vehicule vehicule) async {
    final response = await http.put(
      Uri.parse("${AppServer.VEHICULE}/$vehiculeId"),
      body: jsonEncode(vehicule.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Vehicule.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour du véhicule");
    }
  }

  Future<void> delete(String vehiculeId) async {
    final response = await http.delete(Uri.parse("${AppServer.VEHICULE}/$vehiculeId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression du véhicule");
    }
  }
}