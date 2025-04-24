import 'Utilisateur.dart';

class Messagerie {
  int? messageId;
  String? utilisateurId;
  String? contenu;
  DateTime? dateEnvoi;
  Utilisateur? utilisateurIdAsso4;

  Messagerie({
    this.messageId,
    this.utilisateurId,
    this.contenu,
    this.dateEnvoi,
    this.utilisateurIdAsso4,
  });

  factory Messagerie.fromJson(Map<String, dynamic> json) {
    return Messagerie(
      messageId: json["messageId"],
      utilisateurId: json["utilisateurId"],
      contenu: json["contenu"],
      dateEnvoi: json["dateEnvoi"] != null ? DateTime.parse(json["dateEnvoi"]) : null,
      utilisateurIdAsso4: json["utilisateurIdAsso4"] != null ? Utilisateur.fromJson(json["utilisateurIdAsso4"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': this.messageId,
      'utilisateurId': this.utilisateurId,
      'contenu': this.contenu,
      'dateEnvoi': this.dateEnvoi?.toIso8601String(),
      'utilisateurIdAsso4': this.utilisateurIdAsso4?.toJson(),
    };
  }
}