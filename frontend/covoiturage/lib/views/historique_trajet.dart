import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../constants/colors.dart';
import '../constants/image_string.dart';
import '../constants/server.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';

class ReservationWidget extends StatefulWidget {
  const ReservationWidget({super.key});

  @override
  _ReservationWidgetState createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  String message = "";
  bool _isLoading = true;
  List<Map<String, dynamic>>? _userDataList;

  @override
  void initState() {
    super.initState();
    displayUserData();
  }

  Future<void> displayUserData() async {
    String uid = "reservationId"; // Get the user ID from your auth system
      final response = await http.get(Uri.parse(AppServer.RESERVATION));

    if (response.statusCode == 200) {
      var userDataList = jsonDecode(response.body) as List;
      setState(() {
        _userDataList = userDataList.map((data) => data as Map<String, dynamic>).toList();
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteReservation(String reservationId) async {
    final response = await http.delete(Uri.parse('http://yourapi.com/reservations/$reservationId'));

    if (response.statusCode == 204) {
      setState(() {
        _userDataList!.removeWhere((reservation) => reservation['id'] == reservationId);
      });
    } else {
      // Handle error
    }
  }

  Widget buildReservationCard(Map<String, dynamic> reservationData) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildReservationDetailRow('Ville de départ', reservationData['villedepart']),
          buildReservationDetailRow('Ville d\'arrivée', reservationData['villeArriver']),
          buildReservationDetailRow('Heure de départ', reservationData['heurDepart']),
          buildReservationDetailRow('Prix à payer', '${reservationData['prix']} FCFA'),
          buildReservationDetailRow('Date du voyage', reservationData['date']),
          buildReservationDetailRow('Numéro de siège', reservationData['numerosierge']),
          buildReservationDetailRow('Nombre de places', reservationData['nombre_personne']),
          buildActionButtons(reservationData['id']),
        ],
      ),
    );
  }

  Widget buildReservationDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        Text(value, style: GoogleFonts.poppins()),
      ],
    );
  }

  Widget buildActionButtons(String reservationId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => _deleteReservation(reservationId),
          child: Text("Supprimer", style: GoogleFonts.poppins(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            // Handle ticket validation or payment
          },
          child: Text("Valider le ticket", style: GoogleFonts.poppins(color: appcolor)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Historique des réservations",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17, color: appcolor),
        ),
        actions: [
          IconButton(
            onPressed: displayUserData,
            icon: Icon(Icons.refresh, color: appcolor),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (_userDataList == null || _userDataList!.isEmpty
          ? Center(child: Text("Votre historique est vide !!", style: GoogleFonts.poppins()))
          : ListView.builder(
        itemCount: _userDataList!.length,
        itemBuilder: (context, index) {
          return buildReservationCard(_userDataList![index]);
        },
      )),
    );
  }
}