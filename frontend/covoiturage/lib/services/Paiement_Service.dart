import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Paiement.dart';

class PaiementService {
  Future<List<Paiement>> getAllPaiements() async {
    final response = await http.get(Uri.parse(AppServer.PAIEMENT));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Paiement.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des paiements");
    }
  }

  Future<Paiement> savePaiement(Paiement paiement) async {
    final response = await http.post(
      Uri.parse(AppServer.PAIEMENT),
      body: jsonEncode(paiement.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Paiement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout du paiement");
    }
  }

  Future<Paiement> updatePaiement(String paiementId, Paiement paiement) async {
    final response = await http.put(
      Uri.parse("${AppServer.PAIEMENT}/$paiementId"),
      body: jsonEncode(paiement.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Paiement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour du paiement");
    }
  }

  Future<void> deletePaiement(String paiementId) async {
    final response = await http.delete(Uri.parse("${AppServer.PAIEMENT}/$paiementId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression du paiement");
    }
  }
}