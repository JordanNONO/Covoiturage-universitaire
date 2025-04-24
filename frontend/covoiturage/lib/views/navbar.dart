import 'package:covoiturage/models/Utilisateur.dart';
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
  final controller = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value, // Add .value to get the int from RxInt
          children: [
            HomeScreen(),
            TrajetsListScreen(), // Make sure Utilisateur() returns a Widget
            ReservationWidget(),
            PlaceListPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.tabIndex.value, // Add .value here too
          onTap: (index) => controller.changeTabIndex(index), // Ensure this expects an int
          selectedItemColor: appcolor,
          unselectedItemColor: Colors.grey,
          items: [
            _bottomBarItem(IconlyBold.home, "Home"),
            _bottomBarItem(IconlyBold.ticket, "Trajet"),
            _bottomBarItem(IconlyBold.user_2, "Users"),
            _bottomBarItem(IconlyBold.time_circle, "Historique"),
            _bottomBarItem(Icons.monetization_on, "Tarif"),
          ],
        ),
      );
    });
  }

  BottomNavigationBarItem _bottomBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}