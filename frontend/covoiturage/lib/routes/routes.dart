import 'package:covoiturage/Admin/Login_screen.dart';
import 'package:covoiturage/Admin/home_screen.dart';
import 'package:covoiturage/on_boarding/on_boarding_screen.dart';
import 'package:covoiturage/views/splashcreen.dart';
import 'package:covoiturage/views/utilisateur.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Admin/Admin_HomePage.dart';
import '../Admin/Create_trajet.dart';
import '../Admin/Trajet.dart';
import '../Admin/navbar.dart';
import '../views/historique_trajet.dart';

class AppPage {
  static String navbar = '/';
  static String on_boarding = '/on_boarding';
  static String homescreen = '/homescreen';
  static String homePage = '/homePage';
  static String registrationpage = '/RegistrationPage';
  static String createTrajet = '/createTrajet';
  static String historiquereservation = '/historiquereservation';
  static String userReservation = '/userReservation';
  static String AdminTrajets = '/Trajets';
  static String splashscreen = '/splashscreen'; // Corrigé ici sans espace

  static List<GetPage> routes = [
    GetPage(name: navbar, page: () => NavBar()),
    GetPage(name: on_boarding, page: () => OnBoardingScreen()),
    GetPage(name: homescreen, page: () => HomeScreen()),
    GetPage(name: registrationpage, page: () => RegistrationPage()),
    GetPage(name: homePage, page: () => AdminHomePage()),
    GetPage(name: createTrajet, page: () => CreateTrajet()),
    GetPage(name: historiquereservation, page: () => ReservationWidget()),
    // GetPage(name: userReservation , page: ()=> ReservationList()), // à ajouter si besoin
    GetPage(name: AdminTrajets, page: () => Trajets()),
    GetPage(
        name: splashscreen, page: () => Splashscreen()), // Corrigé ici aussi
  ];

  static getNavbar() => navbar;
  static getHome() => homePage;
  static getCreateTrajet() => createTrajet;
  static getHistoriqueReservation() => historiquereservation;
  static getUserReservation() => userReservation;
  static getTrajet() => AdminTrajets;
  static getSplashscreen() => splashscreen;
  static getOnBoardingScreen() => on_boarding;
  static getregistrationpage() => registrationpage;
  static gethomescreen()=> homescreen;
}
