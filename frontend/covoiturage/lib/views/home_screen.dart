import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Assurez-vous d'ajouter ce package

import '../../../constants/colors.dart';
import '../../../constants/image_string.dart';
import '../../../constants/possitonGeographique.dart';
import '../services/auth_service.dart';
import 'DrawerPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _mapStyle;
  GoogleMapController? myMapController;

  @override
  final AuthService authService = Get.find<AuthService>();
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.text').then((String style) {
      _mapStyle = style;
    });
    _getUserLocation(); // Obtenir la position de l'utilisateur au démarrage
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(CamerounDoualaLatitude, CamerounDoualaLongitude),
    zoom: 14.4746,
  );

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Covoiturage Universitaire App",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: appcolor),
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
              icon: Image(image: AssetImage(userIcon)),
            ),
          )
        ],
      ),
      drawer: DrawerNavigator(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildInfoCard(),
            SizedBox(height: 15),
            _buildMap(),
            SizedBox(height: 10),
            Text(
              "Vous pouvez réserver en :",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            _buildReservationOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor1,
        boxShadow: [
          BoxShadow(
            color: appcolor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(image: AssetImage(calender), width: 60, height: 50),
          Column(
            children: [
              Text(
                "Le confort de nos \n passagers est notre priorité",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              myMapController = controller;
              myMapController?.setMapStyle(_mapStyle);
            },
            initialCameraPosition: _kGooglePlex,
          ),
          _buildCurrentLocation(),
        ],
      ),
    );
  }

  Widget _buildCurrentLocation() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 8),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: appcolor,
          child: InkWell(
            onTap: _getUserLocation,
            child: Icon(Icons.my_location, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildReservationOptions() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildReservationOption("Business class", business),
          _buildReservationOption("Master class", vip),
          _buildReservationOption("Premium", null, icon: Icons.star_border),
        ],
      ),
    );
  }

  Widget _buildReservationOption(String title, String? imagePath, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon != null ? Icon(icon, size: 30, color: appcolor) : Image(image: AssetImage(imagePath!), width: 30, height: 30),
            SizedBox(width: 10),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15)),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}