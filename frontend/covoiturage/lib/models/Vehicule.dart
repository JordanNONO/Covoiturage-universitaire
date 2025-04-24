import 'Trajet.dart';
import 'Utilisateur.dart';

class Vehicule {
  String? vehiculeId;
  String? utilisateurId;
  String? marque;
  String? modele;
  int? annee;
  String? immatriculation;
  int? placesDisponibles;
  String? couleur;
  Trajet? trajetId;
  Utilisateur? utilisateurIdAsso6;

  Vehicule({
    this.vehiculeId,
    this.utilisateurId,
    this.marque,
    this.modele,
    this.annee,
    this.immatriculation,
    this.placesDisponibles,
    this.couleur,
    this.trajetId,
    this.utilisateurIdAsso6,
  });

  factory Vehicule.fromJson(Map<String, dynamic> json) {
    return Vehicule(
      vehiculeId: json["vehiculeId"],
      utilisateurId: json["utilisateurId"],
      marque: json["marque"],
      modele: json["modele"],
      annee: json["annee"],
      immatriculation: json["immatriculation"],
      placesDisponibles: json["placesDisponibles"],
      couleur: json["couleur"],
      trajetId: json["trajetId"] != null ? Trajet.fromJson(json["trajetId"]) : null,
      utilisateurIdAsso6: json["utilisateurIdAsso6"] != null ? Utilisateur.fromJson(json["utilisateurIdAsso6"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehiculeId': this.vehiculeId,
      'utilisateurId': this.utilisateurId,
      'marque': this.marque,
      'modele': this.modele,
      'annee': this.annee,
      'immatriculation': this.immatriculation,
      'placesDisponibles': this.placesDisponibles,
      'couleur': this.couleur,
      'trajetId': this.trajetId?.toJson(),
      'utilisateurIdAsso6': this.utilisateurIdAsso6?.toJson(),
    };
  }
}