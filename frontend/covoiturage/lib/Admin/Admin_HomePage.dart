import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../constants/colors.dart';
import '../../models/Trajet.dart';
import '../../models/Utilisateur.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _userCount = 0;
  int _trajetNumber = 0;

  @override
  void initState() {
    super.initState();
    _getUserCount();
    _getTrajetCount();
  }

  Future<void> _getUserCount() async {
    try {
      _userCount = await Utilisateur.getCountUtilisateur();
      setState(() {});
    } catch (e) {
      print("Erreur de récupération des utilisateurs : $e");
    }
  }

  Future<void> _getTrajetCount() async {
    try {
      _trajetNumber = await Trajet.getTrajetCount(); // Ajustez selon votre méthode
      setState(() {});
    } catch (e) {
      print("Erreur de récupération des trajets : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Admin", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: appcolor)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {
            // Sign out logic
          }, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tableau de bord", style: GoogleFonts.roboto(fontSize: 20)),
                  Icon(Icons.dashboard_customize, color: appcolor, size: 30),
                ],
              ),
            ),
            SizedBox(height: 10),
            _buildUserStatsCard(),
            SizedBox(height: 20),
            _buildTrajetStatsCard(),
            SizedBox(height: 20),
            _buildWorkStatsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatsCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: appcolor.withOpacity(0.5), spreadRadius: 2, blurRadius: 5)],
        color: Colors.amber,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 5.0,
            percent: _userCount / 100, // Ajustez selon vos besoins
            progressColor: Colors.green,
            backgroundColor: Colors.white,
            center: Text("$_userCount", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          Text("Total d'utilisateurs : $_userCount", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTrajetStatsCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: appcolor.withOpacity(0.5), spreadRadius: 2, blurRadius: 5)],
        color: appcolor,
      ),
      child: Column(
        children: [
          Text("Nombre de Trajets : $_trajetNumber", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 5),
          Row(
            children: [
              Container(width: 100, height: 10, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white)),
              Text("12 %", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkStatsCard() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerAD,
      ),
      child: Column(
        children: [
          Text("Mes travaux", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
          // Ajoutez d'autres statistiques ou graphiques ici
        ],
      ),
    );
  }
}