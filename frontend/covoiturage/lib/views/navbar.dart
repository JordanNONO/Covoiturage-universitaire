import 'package:covoiturage/models/Utilisateur.dart';
import 'package:covoiturage/views/create_trajet.dart';
import 'package:covoiturage/views/profile_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../constants/colors.dart';
import '../controllers/navbar_controller.dart';
import 'historique_trajet.dart';
import 'home_screen.dart';
import 'show_trajet.dart';
import 'tarifs.dart';
import 'utilisateur.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller = Get.put(NavbarController()); // Initialisation du contrôleur ici

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: [
            HomeScreen(),
            CreateTrajet(),
            TrajetsListScreen(),
            PlaceListPage(),
            ProfileSettingScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTabIndex,
          selectedItemColor: appcolor,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          backgroundColor: Colors.white,
          items: [
            _bottomBarItem(IconlyBold.home, "Accueil"),
            _bottomBarItem(IconlyBold.arrow_down_circle, "Ajouter"),
            _bottomBarItem(IconlyBold.category, "Utilisateurs"),
            _bottomBarItem(IconlyBold.time_circle, "Historique"),
            _bottomBarItem(IconlyBold.user_2, "Profil"), // Changement d'icône et de libellé
          ],
        ),
      );
    });
  }

  BottomNavigationBarItem _bottomBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Icon(icon, size: 26),
      ),
      label: label,
    );
  }
}