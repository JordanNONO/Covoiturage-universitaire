import 'package:covoiturage/routes/routes.dart';
import 'package:covoiturage/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialiser le service d'authentification
    Get.put(AuthService());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covoiturage',
      initialRoute: AppRoutes.onboardingRoute, // Utilisez la constante de route
      getPages: AppRoutes.all, // Utilisez la liste des routes
      theme: ThemeData(
        primarySwatch: Colors.purple, // Ajout d'une couleur principale
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
