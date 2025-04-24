import 'Utilisateur.dart';

class Role {
  String? roleId;
  String? roleName;
  String? roleDesc;
  Utilisateur? utilisateurId;

  Role({
    this.roleId,
    this.roleName,
    this.roleDesc,
    this.utilisateurId,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json["roleId"],
      roleName: json["roleName"],
      roleDesc: json["roleDesc"],
      utilisateurId: json["utilisateurId"] != null ? Utilisateur.fromJson(json["utilisateurId"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': this.roleId,
      'roleName': this.roleName,
      'roleDesc': this.roleDesc,
      'utilisateurId': this.utilisateurId?.toJson(),
    };
  }
}