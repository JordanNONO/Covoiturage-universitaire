import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../constants/colors.dart';
import '../../controllers/navbar_controller.dart';
import '../views/create_trajet.dart';
import 'Admin_HomePage.dart';
import 'Trajet.dart';
// Assurez-vous d'importer votre NavbarController

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final NavbarController controller = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value, // Utilisez .value pour accéder à la valeur
          children: [
            AdminHomePage(),
            CreateTrajet(),
            // ReservationList(), // Assurez-vous que cette vue est implémentée
            Trajets(), // Assurez-vous que cette vue est implémentée
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTabIndex,
          selectedItemColor: appcolor,
          unselectedItemColor: Colors.grey,
          items: [
            _bottomBarItem(IconlyBold.home, "Accueil"),
            _bottomBarItem(IconlyBold.arrow_down_circle, "Créer Trajet"),
            _bottomBarItem(IconlyBold.time_circle, "Réservations"),
            _bottomBarItem(IconlyBold.category, "Trajets"),
          ],
        ),
      );
    });
  }

  BottomNavigationBarItem _bottomBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}