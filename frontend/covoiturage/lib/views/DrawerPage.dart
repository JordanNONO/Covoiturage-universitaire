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
      width: 270, // Légèrement plus large pour un meilleur espacement
      backgroundColor: Colors.grey[50], // Un gris clair subtil pour l'arrière-plan
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.person_outline,
                  text: "Mon Profil",
                  onTap: () => Get.to(ProfileSettingScreen()),
                ),
                Divider(thickness: 0.8, color: Colors.grey[300]),
                _buildDrawerItem(
                  icon: Icons.route_outlined,
                  text: "Mes Trajets",
                  onTap: () => Get.to(TrajetsListScreen()),
                ),
                 Divider(thickness: 0.8, color: Colors.grey[300]),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  text: "Paramètres",
                  onTap: () => Get.to(const HomeScreen()),
                ),
                 Divider(thickness: 0.8, color: Colors.grey[300]),
                _buildDrawerItem(
                  icon: Icons.logout,
                  text: "Se déconnecter",
                  onTap: () async {
                    await authService.logout();
                    Get.offAllNamed('/login');
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Covoiturage App v1.0", // Indication de la version
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20), // Meilleur espacement
      decoration: BoxDecoration(
        color: appcolor,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.to(ProfileSettingScreen()),
            child: CircleAvatar(
              radius: 40, // Taille plus confortable
              backgroundColor: Colors.white,
              child: ClipOval(
                child: photoProfil.isNotEmpty
                    ? Image.network(
                  photoProfil,
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                )
                    : const Icon(Icons.person_outline, size: 40, color: appcolor), // Icône contourée
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nom,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18), // Style plus lisible
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Espacement vertical accru
        child: Row(
          children: [
            Icon(icon, size: 26, color: appcolor), // Taille d'icône cohérente
            const SizedBox(width: 16),
            Text(
              text,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16), // Style de texte uniforme
            ),
          ],
        ),
      ),
    );
  }
}