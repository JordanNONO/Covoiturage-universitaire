import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/Auth_Controller.dart';
import 'on_boarding/on_boarding_screen.dart';

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

    // Vérifier l'état d'authentification au démarrage
    //authController.checkAuthStatus();

    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      home: OnBoardingScreen(),
    );
  }
}