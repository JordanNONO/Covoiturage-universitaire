import 'Utilisateur.dart';

class Avis {
  int? avisId;
  String? utilisateurId;
  double? note;
  String? commentaire;
  DateTime? dateAvis;
  Utilisateur? utilisateurIdAsso1;

  Avis({
    this.avisId,
    this.utilisateurId,
    this.note,
    this.commentaire,
    this.dateAvis,
    this.utilisateurIdAsso1,
  });

  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      avisId: json["avisId"],
      utilisateurId: json["utilisateurId"],
      note: json["note"],
      commentaire: json["commentaire"],
      dateAvis: json["dateAvis"] != null ? DateTime.parse(json["dateAvis"]) : null,
      utilisateurIdAsso1: json["utilisateurIdAsso1"] != null ? Utilisateur.fromJson(json["utilisateurIdAsso1"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avisId': this.avisId,
      'utilisateurId': this.utilisateurId,
      'note': this.note,
      'commentaire': this.commentaire,
      'dateAvis': this.dateAvis?.toIso8601String(),
      'utilisateurIdAsso1': this.utilisateurIdAsso1?.toJson(),
    };
  }
}