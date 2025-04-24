import 'Paiement.dart';
import 'Utilisateur.dart';

class Reservation {
  String? reservationId;
  String? utilisateurId;
  String? trajetId;
  String? statut;
  DateTime? dateReservation;
  String? modePaiement;
  List<Paiement>? paiementCollection;
  Utilisateur? utilisateurIdAsso3;

  Reservation({
    this.reservationId,
    this.utilisateurId,
    this.trajetId,
    this.statut,
    this.dateReservation,
    this.modePaiement,
    this.paiementCollection,
    this.utilisateurIdAsso3,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json["reservationId"],
      utilisateurId: json["utilisateurId"],
      trajetId: json["trajetId"],
      statut: json["statut"],
      dateReservation: json["dateReservation"] != null ? DateTime.parse(json["dateReservation"]) : null,
      modePaiement: json["modePaiement"],
      paiementCollection: json["paiementCollection"] != null ? List<Paiement>.from(json["paiementCollection"].map((x) => Paiement.fromJson(x))) : null,
      utilisateurIdAsso3: json["utilisateurIdAsso3"] != null ? Utilisateur.fromJson(json["utilisateurIdAsso3"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': this.reservationId,
      'utilisateurId': this.utilisateurId,
      'trajetId': this.trajetId,
      'statut': this.statut,
      'dateReservation': this.dateReservation?.toIso8601String(),
      'modePaiement': this.modePaiement,
      'paiementCollection': this.paiementCollection != null ? List<dynamic>.from(paiementCollection!.map((x) => x.toJson())) : null,
      'utilisateurIdAsso3': this.utilisateurIdAsso3?.toJson(),
    };
  }
}