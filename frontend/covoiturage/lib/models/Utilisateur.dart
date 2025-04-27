import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

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

  Utilisateur({
    this.utilisateurId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    required this.telephone,
    this.dateInscription,
    this.noteMoyenne,
    this.photoProfil,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utilisateurId': utilisateurId,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motDePasse': motDePasse,
      'telephone': telephone,
      'dateInscription': dateInscription?.toIso8601String(),
      'noteMoyenne': noteMoyenne,
      'photoProfil': photoProfil,
    };
  }
}