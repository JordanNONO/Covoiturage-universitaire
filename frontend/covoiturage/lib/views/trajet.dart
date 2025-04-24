import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants/colors.dart';
import '../models/Trajet.dart';

class TrajetList extends StatefulWidget {
  const TrajetList({Key? key}) : super(key: key);

  @override
  _TrajetListState createState() => _TrajetListState();
}

class _TrajetListState extends State<TrajetList> {
  List<Trajet> trajets = []; // Liste pour stocker les trajets
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrajets(); // Récupérer les trajets lors de l'initialisation du widget
  }

  Future<void> fetchTrajets() async {
    try {
      final response = await http.get(Uri.parse(AppServer.TRAJET)); // Remplacez par votre endpoint
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          trajets = data.map((json) => Trajet.fromJson(json)).toList(); // Assurez-vous que votre modèle Trajet a une méthode fromJson
          isLoading = false;
        });
      } else {
        throw Exception('Échec du chargement des trajets');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false; // Arrêter le chargement en cas d'erreur
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Trajets", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: appcolor)),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 400,
              height: 60,
              padding: EdgeInsets.only(top: 5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
                color: appcolor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Départ", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(width: 50),
                  Icon(Icons.transfer_within_a_station, color: Colors.white),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text("Arrivée", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  Text("Trajet Disponibles", style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("${trajets.length} places", style: GoogleFonts.montserrat(fontSize: 14), textAlign: TextAlign.right),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: Get.height * 0.7, // Ajustez la hauteur si nécessaire
              width: 400,
              child: ListView.builder(
                itemCount: trajets.length,
                itemBuilder: (context, index) {
                  final trajet = trajets[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.bus_alert_outlined, size: 50, color: appcolor),
                        SizedBox(height: 10),
                        Text(trajet.depart ?? "N/A", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                        Text(trajet.destination ?? "N/A", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16)),
                        Text("Tarif: ${trajet.tarif?.toString() ?? 'N/A'} FCFA", style: GoogleFonts.poppins()),
                        Text("Places Disponibles: ${trajet.placesDisponibles?.toString() ?? 'N/A'}", style: GoogleFonts.poppins()),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}