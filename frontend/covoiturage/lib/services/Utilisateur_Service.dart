import 'dart:convert';
import 'dart:io'; // Import pour gérer les fichiers
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Utilisateur.dart';

class UtilisateurService {
  Future<List<Utilisateur>> getAll() async {
    final response = await http.get(Uri.parse(AppServer.UTILISATEUR));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Utilisateur.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des utilisateurs");
    }
  }

  Future<Utilisateur> save(Utilisateur utilisateur, File? photoProfil) async {
    var request = http.MultipartRequest('POST', Uri.parse(AppServer.UTILISATEUR));

    // Ajoutez les champs de l'utilisateur
    request.fields['nom'] = utilisateur.nom!;
    request.fields['prenom'] = utilisateur.prenom!;
    request.fields['email'] = utilisateur.email!;
    request.fields['motDePasse'] = utilisateur.motDePasse!;
    request.fields['telephone'] = utilisateur.telephone!;

    // Ajoutez la photoProfil si elle existe
    if (photoProfil != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'photoProfil',
        photoProfil.path,
      ));
    }

    // Ajoutez les en-têtes si nécessaire
    request.headers.addAll(AppServer.headers);

    var response = await request.send();

    if (response.statusCode == 201) {
      final responseData = await http.Response.fromStream(response);
      return Utilisateur.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception("Échec de l'ajout de l'utilisateur");
    }
  }

  Future<Utilisateur> update(String utilisateurId, Utilisateur utilisateur) async {
    final response = await http.put(
      Uri.parse("${AppServer.UTILISATEUR}/$utilisateurId"),
      body: jsonEncode(utilisateur.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Utilisateur.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour de l'utilisateur");
    }
  }

  Future<void> delete(String utilisateurId) async {
    final response = await http.delete(Uri.parse("${AppServer.UTILISATEUR}/$utilisateurId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression de l'utilisateur");
    }
  }

  // Nouvelle méthode pour obtenir le nombre total d'utilisateurs
  Future<int> getUserCount(String utilisateurId) async {
    final response = await http.get(Uri.parse('${AppServer.UTILISATEUR}/$utilisateurId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['utilisateurId']; // Assurez-vous que votre API renvoie un objet avec une clé 'count'
    } else {
      throw Exception("Échec de récupération du nombre d'utilisateurs");
    }
  }
}