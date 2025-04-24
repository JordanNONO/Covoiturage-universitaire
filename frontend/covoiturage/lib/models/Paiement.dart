import 'Reservation.dart';

class Paiement {
  String? paiementId;
  double? montant;
  String? methode;
  String? statut;
  DateTime? datePaiement;
  Reservation? reservationId;

  Paiement({
    this.paiementId,
    this.montant,
    this.methode,
    this.statut,
    this.datePaiement,
    this.reservationId,
  });

  factory Paiement.fromJson(Map<String, dynamic> json) {
    return Paiement(
      paiementId: json["paiementId"],
      montant: json["montant"],
      methode: json["methode"],
      statut: json["statut"],
      datePaiement: json["datePaiement"] != null ? DateTime.parse(json["datePaiement"]) : null,
      reservationId: json["reservationId"] != null ? Reservation.fromJson(json["reservationId"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paiementId': this.paiementId,
      'montant': this.montant,
      'methode': this.methode,
      'statut': this.statut,
      'datePaiement': this.datePaiement?.toIso8601String(),
      'reservationId': this.reservationId?.toJson(),
    };
  }
}