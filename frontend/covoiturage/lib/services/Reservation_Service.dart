import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/server.dart';
import '../models/Reservation.dart';

class ReservationService {
  Future<List<Reservation>> getAllReservations() async {
    final response = await http.get(Uri.parse(AppServer.RESERVATION));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Reservation.fromJson(json)).toList();
    } else {
      throw Exception("Échec de récupération des réservations");
    }
  }

  Future<Reservation> save(Reservation reservation) async {
    final response = await http.post(
      Uri.parse(AppServer.RESERVATION),
      body: jsonEncode(reservation.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 201) {
      return Reservation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de l'ajout de la réservation");
    }
  }

  Future<Reservation> update(String reservationId, Reservation reservation) async {
    final response = await http.put(
      Uri.parse("${AppServer.RESERVATION}/$reservationId"),
      body: jsonEncode(reservation.toJson()),
      headers: AppServer.headers,
    );
    if (response.statusCode == 200) {
      return Reservation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Échec de la mise à jour de la réservation");
    }
  }

  Future<void> delete(String reservationId) async {
    final response = await http.delete(Uri.parse("${AppServer.RESERVATION}/$reservationId"));
    if (response.statusCode != 204) {
      throw Exception("Échec de la suppression de la réservation");
    }
  }
}