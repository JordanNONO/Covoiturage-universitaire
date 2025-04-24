import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Role.dart';

class RoleService {
  Future<List<Role>> getAllRoles() async {
    final response = await http.get(Uri.parse(AppServer.ROLE));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Role.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des rôles");
    }
  }

  Future<Role> saveRole(Role role) async {
    final response = await http.post(
      Uri.parse(AppServer.ROLE),
      body: jsonEncode(role.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Role.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout du rôle");
    }
  }

  Future<Role> updateRole(String roleId, Role role) async {
    final response = await http.put(
      Uri.parse("${AppServer.ROLE}/$roleId"),
      body: jsonEncode(role.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Role.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour du rôle");
    }
  }

  Future<void> deleteRole(String roleId) async {
    final response = await http.delete(Uri.parse("${AppServer.ROLE}/$roleId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression du rôle");
    }
  }
}