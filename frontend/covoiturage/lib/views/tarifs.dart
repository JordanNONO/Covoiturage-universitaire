import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants/colors.dart';

class Place {
  final String name;
  final String description;
  final double price;

  Place({required this.name, required this.description, required this.price});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }
}

class PlaceListPage extends StatefulWidget {
  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  bool isLoading = true;
  List<Place> places = [];

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  Future<void> fetchPlaces() async {
    try {
      final response = await http.get(Uri.parse(AppServer.PAIEMENT)); // Remplacez par votre endpoint
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          places = data.map((json) => Place.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Échec du chargement des lieux');
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
        title: Text(
          "Nos Tarifs",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17, color: appcolor),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          final place = places[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                SizedBox(height: 8.0),
                Text(
                  place.description,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${place.price} FCFA',
                  style: GoogleFonts.roboto(fontSize: 15),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}