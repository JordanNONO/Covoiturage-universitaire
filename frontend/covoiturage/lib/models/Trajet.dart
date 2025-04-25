import 'dart:convert';

import 'package:covoiturage/constants/server.dart';
import 'package:http/http.dart' as http;

import 'Utilisateur.dart';
import 'Vehicule.dart';

class Trajet {
  String? trajetId;
  String? utilisateurId;
  String? vehiculeId;
  String? depart;
  String? destination;
  DateTime? dateHeureDepart;
  double? tarif;
  int? placesDisponibles;
  Utilisateur? utilisateurIdAsso5;
  List<Utilisateur>? utilisateurCollection;
  List<Vehicule>? vehiculeCollection;

  Trajet({
    this.trajetId,
    this.utilisateurId,
    this.vehiculeId,
    this.depart,
    this.destination,
    this.dateHeureDepart,
    this.tarif,
    this.placesDisponibles,
    this.utilisateurIdAsso5,
    this.utilisateurCollection,
    this.vehiculeCollection,
  });

  factory Trajet.fromJson(Map<String, dynamic> json) {
    return Trajet(
      trajetId: json["trajetId"],
      utilisateurId: json["utilisateurId"],
      vehiculeId: json["vehiculeId"],
      depart: json["depart"],
      destination: json["destination"],
      dateHeureDepart: json["dateHeureDepart"] != null ? DateTime.parse(json["dateHeureDepart"]) : null,
      tarif: json["tarif"],
      placesDisponibles: json["placesDisponibles"],
      utilisateurIdAsso5: json["utilisateurIdAsso5"] != null ? Utilisateur.fromJson(json["utilisateurIdAsso5"]) : null,
      utilisateurCollection: json["utilisateurCollection"] != null ? List<Utilisateur>.from(json["utilisateurCollection"].map((x) => Utilisateur.fromJson(x))) : null,
      vehiculeCollection: json["vehiculeCollection"] != null ? List<Vehicule>.from(json["vehiculeCollection"].map((x) => Vehicule.fromJson(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trajetId': this.trajetId,
      'utilisateurId': this.utilisateurId,
      'vehiculeId': this.vehiculeId,
      'depart': this.depart,
      'destination': this.destination,
      'dateHeureDepart': this.dateHeureDepart?.toIso8601String(),
      'tarif': this.tarif,
      'placesDisponibles': this.placesDisponibles,
      'utilisateurIdAsso5': this.utilisateurIdAsso5?.toJson(),
      'utilisateurCollection': this.utilisateurCollection != null ? List<dynamic>.from(utilisateurCollection!.map((x) => x.toJson())) : null,
      'vehiculeCollection': this.vehiculeCollection != null ? List<dynamic>.from(vehiculeCollection!.map((x) => x.toJson())) : null,
    };
  }

  static Future<int> getTrajetCount() async {
    try {
      final response = await http.get(Uri.parse(AppServer.TRAJET)); // Replace with your API endpoint
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
       return data['count'] ?? 0; // Assuming the API returns a JSON object with a 'count' field
      } else {
        throw Exception('Failed to load trajet count');
      }
    } catch (e) {
      print('Error fetching trajet count: $e');
      return 0; // Return 0 in case of error
    }
  }
}