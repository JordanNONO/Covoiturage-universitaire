import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../constants/colors.dart';
import '../../constants/image_string.dart';
import '../constants/server.dart';

class Reservation {
  final String? reservationId;
  final String? utilisateurId;
  final int? trajetId;
  final String? statut;
  final DateTime? dateReservation;
  final String? modePaiement;
  final String? Depart;
  final String? Arriver;
  final String? nomUtilisateur;
  final String? typeVoyage;
  final int? nombrePersonne;

  Reservation({
    this.reservationId,
    this.utilisateurId,
    this.trajetId,
    this.statut,
    this.dateReservation,
    this.modePaiement,
    this.Depart,
    this.Arriver,
    this.nomUtilisateur,
    this.typeVoyage,
    this.nombrePersonne,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservationId'],
      utilisateurId: json['utilisateurId'],
      trajetId: json['trajetId'],
      statut: json['statut'],
      dateReservation: json['dateReservation'] != null ? DateTime.parse(json['dateReservation']) : null,
      modePaiement: json['modePaiement'],
      Depart: json['Depart'],
      Arriver: json['Arriver'],
      nomUtilisateur: json['nomUtilisateur'],
      typeVoyage: json['typeVoyage'],
      nombrePersonne: json['nombrePersonne'],
    );
  }
}

class ReservationList extends StatefulWidget {
  const ReservationList({super.key});

  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  Future<List<Reservation>> getAllReservations() async {
    final String apiUrl = AppServer.RESERVATION; // Remplacez par l'URL de votre API

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((json) => Reservation.fromJson(json)).toList();
      } else {
        print('Erreur lors de la récupération des réservations: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Erreur de connexion ou autre: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Historique de réservation client",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: appcolor),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: IconButton(
              onPressed: () {},
              icon: Image(
                image: AssetImage(userIcon),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Reservation>>(
          future: getAllReservations(),
          builder: (BuildContext context, AsyncSnapshot<List<Reservation>> snapshot) {
            if (snapshot.hasError) {
              return Text("Une erreur s'est produite");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              final List<Reservation>? reservationsData = snapshot.data;

              if (reservationsData == null || reservationsData.isEmpty) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(
                        child: Text(
                          "Pas de réservation client !!",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Image(
                        image: AssetImage(notfound),
                        width: 200,
                        height: 200,
                      ),
                    )
                  ],
                );
              }

              return ListView.builder(
                itemCount: reservationsData.length,
                itemBuilder: (context, index) {
                  final Reservation reservation = reservationsData[index];
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ville de départ',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            Text('Ville d\'arrivée',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${reservation.Depart}',
                                style: GoogleFonts.poppins(fontSize: 13)),
                            Image(
                              image: AssetImage(flech),
                              height: 30,
                              width: 30,
                            ),
                            Text('${reservation.Arriver}',
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ],
                        ),
                        SizedBox(height: 6),
                        Divider(color: Colors.grey),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nom du client',
                                style: GoogleFonts.poppins(fontSize: 13)),
                            Text('${reservation.nomUtilisateur}',
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ],
                        ),
                        Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('date reservé', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('${reservation.dateReservation?.toLocal().toString().split(' ')[0]}',
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('type de voyage', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('${reservation.typeVoyage}',
                                style: GoogleFonts.poppins(fontSize: 13, color: CupertinoColors.activeBlue)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('nombre de personne', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('${reservation.nombrePersonne}',
                                style: GoogleFonts.poppins(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 150),
                  child: Center(
                    child: Text("chargement en cour .... !!",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(color: appcolor,),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}