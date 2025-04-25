
import 'package:covoiturage/on_boarding/on_boarding_screen.dart';
import 'package:covoiturage/views/login.dart';
import 'package:covoiturage/views/utilisateur.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/historique_trajet.dart';
import '../views/navbar.dart';

class AppPage {
  static String navbar = '/';
  static String on_boarding = '/on_boarding';
  static String LoginScreen = '/login';
  static String homePage = '/homePage';
  static String registrationpage = '/RegistrationPage';
  static String createTrajet = '/createTrajet';
  static String historiquereservation = '/historiquereservation';
  static String userReservation = '/userReservation';
  static String AdminTrajets = '/Trajets';
  static List<GetPage> routes = [
    GetPage(name: navbar, page: () => NavBar()),
    GetPage(name: on_boarding, page: () => OnBoardingScreen()),
    GetPage(name: LoginScreen, page: () => LoginScreen),
    GetPage(name: homePage, page: () => AdminHomePage()),
    GetPage(name: createTrajet, page: () => CreateTrajet()),
    GetPage(name: historiquereservation, page: () => ReservationWidget()),
    // GetPage(name: userReservation , page: ()=> ReservationList()), // à ajouter si besoin
    GetPage(name: AdminTrajets, page: () => Trajets()),
    // Corrigé ici aussi
    ];

  static getNavbar() => navbar;
  static getHome() => homePage;
  static getCreateTrajet() => createTrajet;
  static getHistoriqueReservation() => historiquereservation;
  static getUserReservation() => userReservation;
  static getTrajet() => AdminTrajets;
  static getOnBoardingScreen() => on_boarding;
  static gethomescreen()=> homescreen;
}
