import 'dart:convert';

import 'package:covoiturage/constants/server.dart';
import 'package:http/http.dart' as http;

import 'Avis.dart';
import 'Messagerie.dart';
import 'Reservation.dart';
import 'Role.dart';
import 'Trajet.dart';
import 'Vehicule.dart';

class Utilisateur {
  String? utilisateurId;
  String? nom;
  String? prenom;
  String? email;
  String? motDePasse;
  String? telephone;
  DateTime? dateInscription;
  double? noteMoyenne;
  String? photoProfil;
  List<Trajet>? trajetCollection;
  List<Avis>? avisCollection;
  List<Role>? roleCollection;
  Trajet? trajetId;
  List<Vehicule>? vehiculeCollection;
  List<Reservation>? reservationCollection;
  List<Messagerie>? messagerieCollection;

  Utilisateur({
    this.utilisateurId,
    this.nom,
    this.prenom,
    this.email,
    this.motDePasse,
    this.telephone,
    this.dateInscription,
    this.noteMoyenne,
    this.photoProfil,
    this.trajetCollection,
    this.avisCollection,
    this.roleCollection,
    this.trajetId,
    this.vehiculeCollection,
    this.reservationCollection,
    this.messagerieCollection,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      utilisateurId: json["utilisateurId"],
      nom: json["nom"],
      prenom: json["prenom"],
      email: json["email"],
      motDePasse: json["motDePasse"],
      telephone: json["telephone"],
      dateInscription: json["dateInscription"] != null ? DateTime.parse(json["dateInscription"]) : null,
      noteMoyenne: json["noteMoyenne"],
      photoProfil: json["photoProfil"],
      trajetCollection: json["trajetCollection"] != null ? List<Trajet>.from(json["trajetCollection"].map((x) => Trajet.fromJson(x))) : null,
      avisCollection: json["avisCollection"] != null ? List<Avis>.from(json["avisCollection"].map((x) => Avis.fromJson(x))) : null,
      roleCollection: json["roleCollection"] != null ? List<Role>.from(json["roleCollection"].map((x) => Role.fromJson(x))) : null,
      trajetId: json["trajetId"] != null ? Trajet.fromJson(json["trajetId"]) : null,
      vehiculeCollection: json["vehiculeCollection"] != null ? List<Vehicule>.from(json["vehiculeCollection"].map((x) => Vehicule.fromJson(x))) : null,
      reservationCollection: json["reservationCollection"] != null ? List<Reservation>.from(json["reservationCollection"].map((x) => Reservation.fromJson(x))) : null,
      messagerieCollection: json["messagerieCollection"] != null ? List<Messagerie>.from(json["messagerieCollection"].map((x) => Messagerie.fromJson(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utilisateurId': this.utilisateurId,
      'nom': this.nom,
      'prenom': this.prenom,
      'email': this.email,
      'motDePasse': this.motDePasse,
      'telephone': this.telephone,
      'dateInscription': this.dateInscription?.toIso8601String(),
      'noteMoyenne': this.noteMoyenne,
      'photoProfil': this.photoProfil,
      'trajetCollection': this.trajetCollection != null ? List<dynamic>.from(trajetCollection!.map((x) => x.toJson())) : null,
      'avisCollection': this.avisCollection != null ? List<dynamic>.from(avisCollection!.map((x) => x.toJson())) : null,
      'roleCollection': this.roleCollection != null ? List<dynamic>.from(roleCollection!.map((x) => x.toJson())) : null,
      'trajetId': this.trajetId?.toJson(),
      'vehiculeCollection': this.vehiculeCollection != null ? List<dynamic>.from(vehiculeCollection!.map((x) => x.toJson())) : null,
      'reservationCollection': this.reservationCollection != null ? List<dynamic>.from(reservationCollection!.map((x) => x.toJson())) : null,
      'messagerieCollection': this.messagerieCollection != null ? List<dynamic>.from(messagerieCollection!.map((x) => x.toJson())) : null,
    };
  }

  static Future<int> getCountUtilisateur() async {
    try {
      final response = await http.get(Uri.parse(AppServer.UTILISATEUR)); // Replace with your API endpoint
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['utilisateurId'] ?? 0; // Assuming the API returns a JSON object with a 'count' field
      } else {
        throw Exception('Failed to load user count');
      }
    } catch (e) {
      print('Error fetching user count: $e');
      return 0; // Return 0 in case of error
    }
  }
  
}