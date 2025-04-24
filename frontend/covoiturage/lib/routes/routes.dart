import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Admin/Admin_HomePage.dart';
import '../Admin/Create_trajet.dart';
import '../Admin/Trajet.dart';
import '../Admin/navbar.dart';
import '../views/historique_trajet.dart';

class AppPage {
  static List<GetPage> routes = [
    GetPage(name: navbar, page: () => NavBar()),
    GetPage(name: homePage, page: () => AdminHomePage()),
    GetPage(name: createTrajet, page: () => CreateTrajet()),
    GetPage(name: historiquereservation, page: () => ReservationWidget()),
    //GetPage(name: userReservation , page: ()=> ReservationList()),
    GetPage(name: AdminTrajets, page: () => Trajets()),

  ];

  static getnavbar() => navbar;

  static gethome() => homePage;

  static getcreateTrajet() => createTrajet;

  static gethistoriquereservation() => historiquereservation;

  static getUserReservation() => userReservation;

  static getTrajet() => AdminTrajets;

  static String navbar = '/';
  static String homePage = '/homePage';
  static String createTrajet = '/createTrajet';
  static String historiquereservation = '/historiquereservation';
  static String userReservation = '/userReservation ';
  static String AdminTrajets = '/Trajets ';
}
