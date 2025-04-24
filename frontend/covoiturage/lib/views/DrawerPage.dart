import 'package:covoiturage/views/profile_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../controllers/Auth_Controller.dart';
import 'home_screen.dart';

class DrawerNavigator extends StatefulWidget {
  const DrawerNavigator({Key? key}) : super(key: key);

  @override
  State<DrawerNavigator> createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.getUser(); // Récupérer les informations de l'utilisateur
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              authController.myuser.value.nom ?? "", // Remplacez Unom par nom
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            accountEmail: Text(authController.myuser.value.email ?? ""), // Utilisez l'email
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: InkWell(
                onTap: () => Get.to(ProfileSettingScreen()),
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(authController.myuser.value.photoProfil ?? ''), // Utilisez photoProfil
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: appcolor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_sharp, size: 30, color: appcolor),
            title: Text("Mon Profil", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () => Get.to(ProfileSettingScreen()), // Redirige vers l'écran de paramètres de profil
          ),
          Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.add_road, size: 30, color: appcolor),
            title: Text("Trajets", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () => Get.to(HomeScreen()), // Redirige vers l'écran d'accueil
          ),
          Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.settings, size: 30, color: appcolor),
            title: Text("Paramètres", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () => Get.to(HomeScreen()), // Redirige vers l'écran d'accueil
          ),
          Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.login_sharp, size: 30, color: appcolor),
            title: Text("Se déconnecter", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            onTap: () {
            //  authController.SignOut(); // Déconnexion
            //  Get.offAll(Login_screen()); // Remplacez avec votre page de connexion
            },
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}