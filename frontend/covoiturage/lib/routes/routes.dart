import 'package:covoiturage/on_boarding/on_boarding_screen.dart';
import 'package:covoiturage/views/login.dart';
import 'package:covoiturage/views/utilisateur.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../views/create_trajet.dart';
import '../views/historique_trajet.dart';
import '../views/home_screen.dart';
import '../views/navbar.dart';
import '../views/register.dart';

class AppRoutes {
  // Chemins des routes
  static const String initial = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String createTrip = '/create-trip';
  static const String bookingHistory = '/booking-history';
  static const String userBookings = '/user-bookings';
  static const String adminTrips = '/admin/trips';
  static const String homeScreen = '/home-screen';

  // Getters avec documentation
  static String get initialRoute => initial;
  static String get onboardingRoute => onboarding;
  static String get loginRoute => login;
  static String get homeRoute => home;
  static String get registrationRoute => register;
  static String get createTripRoute => createTrip;
  static String get bookingHistoryRoute => bookingHistory;
  static String get userBookingsRoute => userBookings;
  static String get adminTripsRoute => adminTrips;
  static String get homeScreenRoute => homeScreen;

  // Liste des routes avec vérification des dépendances
  static final List<GetPage> all = [
    GetPage(
      name: initial,
      page: () => NavBar(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: onboarding,
      page: () => OnBoardingScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: home,
    //   page: () => AdminHomePage(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: createTrip,
      page: () => CreateTrajet(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: bookingHistory,
      page: () => ReservationWidget(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: adminTrips,
    //   page: () => Trajets(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(), // Assurez-vous que ce widget existe
      transition: Transition.fadeIn,
    ),
  ];

  // Méthode pour vérifier si une route existe
  static bool exists(String routeName) {
    return all.any((route) => route.name == routeName);
  }

  // Méthode pour obtenir une route par son nom
  static GetPage? getByName(String name) {
    try {
      return all.firstWhere((route) => route.name == name);
    } catch (e) {
      return null;
    }
  }
}