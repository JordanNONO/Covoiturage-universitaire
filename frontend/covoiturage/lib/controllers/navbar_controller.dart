import 'package:get/get.dart';

class NavbarController extends GetxController {
  // Variable d'état pour l'index de l'onglet
  var tabIndex = 0.obs;

  // Méthode pour changer l'index de l'onglet
  void changeTabIndex(int index) {
    tabIndex.value = index; // Met à jour l'index et notifie les écouteurs
  }
}