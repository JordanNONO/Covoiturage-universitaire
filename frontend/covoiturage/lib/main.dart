import 'package:covoiturage/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/Auth_Controller.dart';
 // ← Assure-toi que le chemin est correct

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialiser le contrôleur d'authentification
    final authController = Get.put(AuthController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covoiturage',
      initialRoute: AppPage.getOnBoardingScreen(), // ← Route initiale
      getPages: AppPage.routes, // ← Toutes tes routes
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
