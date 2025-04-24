import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../constants/server.dart'; // Assurez-vous d'importer votre fichier de constantes pour l'URL de l'API
import '../../models/Trajet.dart';

class Trajets extends StatefulWidget {
  const Trajets({Key? key}) : super(key: key);

  @override
  State<Trajets> createState() => _TrajetsState();
}

class _TrajetsState extends State<Trajets> {
  List<Trajet> trajets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrajets();
  }

  Future<void> fetchTrajets() async {
    try {
      final response = await http.get(Uri.parse('${AppServer.TRAJET}')); // Remplacez par votre endpoint
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          trajets = data.map((json) => Trajet.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Échec de la récupération des trajets");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Gérer l'erreur ici (afficher un message, etc.)
    }
  }

  Future<void> deleteDocument(String trajetId) async {
    try {
      final response = await http.delete(Uri.parse('${AppServer.TRAJET}/$trajetId')); // Endpoint pour supprimer le trajet
      if (response.statusCode == 204) {
        fetchTrajets(); // Recharger les trajets après suppression
      } else {
        throw Exception("Échec de la suppression du trajet");
      }
    } catch (e) {
      // Gérer l'erreur ici (afficher un message, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Liste des trajets", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17, color: appcolor)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : trajets.isEmpty
          ? Center(child: Text("Pas de trajet disponible !!", style: GoogleFonts.poppins(fontSize: 15)))
          : ListView.builder(
        itemCount: trajets.length,
        itemBuilder: (context, index) {
          final trajet = trajets[index];
          return ListTile(
            title: Text('${trajet.depart} à ${trajet.destination}'),
            subtitle: Text('Départ: ${trajet.dateHeureDepart} - Prix: ${trajet.tarif} FCFA'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteDocument(trajet.trajetId ?? ''),
            ),
          );
        },
      ),
    );
  }
}