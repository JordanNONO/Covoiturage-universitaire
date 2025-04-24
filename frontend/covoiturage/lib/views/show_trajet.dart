import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/Trajet.dart';
import 'create_trajet.dart';
// Assurez-vous d'importer l'écran de création de trajet

class TrajetsListScreen extends StatefulWidget {
  @override
  _TrajetsListScreenState createState() => _TrajetsListScreenState();
}

class _TrajetsListScreenState extends State<TrajetsListScreen> {
  String _searchText = '';
  List<Trajet> trajets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrajets();
  }

  Future<void> fetchTrajets() async {
    try {
      final response = await http.get(Uri.parse(AppServer.TRAJET)); // Remplacez par votre endpoint
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          trajets = data.map((json) => Trajet.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Échec de la récupération des trajets');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Rechercher trajet...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildTrajetsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateTrajet()); // Naviguer vers l'écran de création de trajet
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildTrajetsList() {
    List<Trajet> filteredTrajets = _searchText.isNotEmpty
        ? trajets.where((trajet) =>
    trajet.depart!.toLowerCase().contains(_searchText.toLowerCase()) ||
        trajet.destination!.toLowerCase().contains(_searchText.toLowerCase())).toList()
        : trajets;

    if (filteredTrajets.isEmpty) {
      return Center(
        child: Text("Aucun trajet disponible !!", style: GoogleFonts.poppins(fontSize: 15)),
      );
    }

    return ListView.builder(
      itemCount: filteredTrajets.length,
      itemBuilder: (BuildContext context, int index) {
        final trajet = filteredTrajets[index];
        return InkWell(
          onTap: () {
            // Naviguer vers un écran de détails ou gérer les actions ici
            // Exemple: Get.to(DetailTrajetScreen(trajet: trajet));
          },
          child: Container(
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
                    Text('Ville de départ', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Ville d\'arrivée', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${trajet.depart}', style: GoogleFonts.poppins(fontSize: 13)),
                    Image(image: AssetImage('assets/flech.png'), height: 30, width: 30), // Assurez-vous que l'image existe
                    Text('${trajet.destination}', style: GoogleFonts.poppins(fontSize: 13)),
                  ],
                ),
                SizedBox(height: 6),
                Divider(color: Colors.grey),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${trajet.dateHeureDepart}', style: GoogleFonts.poppins(fontSize: 13)),
                    Text('${trajet.tarif} FCFA', style: GoogleFonts.poppins(fontSize: 13)),
                  ],
                ),
                Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date du voyage', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
                    Text('${trajet.dateHeureDepart}', style: GoogleFonts.poppins(fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}