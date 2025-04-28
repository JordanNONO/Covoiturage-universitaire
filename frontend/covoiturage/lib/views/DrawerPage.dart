import 'package:covoiturage/views/show_trajet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'profile_setting.dart';

class DrawerNavigator extends StatefulWidget {
  const DrawerNavigator({Key? key}) : super(key: key);

  @override
  State<DrawerNavigator> createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  final AuthService authService = AuthService();
  String nom = '';
  String email = '';
  String photoProfil = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom') ?? '';
      email = prefs.getString('email') ?? '';
      photoProfil = prefs.getString('photoProfil') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              nom,
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: InkWell(
                onTap: () => Get.to(ProfileSettingScreen()),
                child: ClipOval(
                  child: photoProfil.isNotEmpty
                      ? Image.network(
                    photoProfil,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  )
                      : const Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: appcolor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_sharp, size: 30, color: appcolor),
            title: Text("Mon Profil", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () => Get.to(ProfileSettingScreen()),
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.add_road, size: 30, color: appcolor),
            title: Text("Trajets", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () => Get.to(TrajetsListScreen()),
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.settings, size: 30, color: appcolor),
            title: Text("Paramètres", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () => Get.to(const HomeScreen()),
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.login_sharp, size: 30, color: appcolor),
            title: Text("Se déconnecter", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () async {
              await authService.logout();
              Get.offAllNamed('/login'); // Adaptez selon votre route de connexion
            },
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}