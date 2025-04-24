import 'dart:convert';
import 'dart:developer';
import 'package:covoiturage/models/Utilisateur.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/server.dart';
import '../views/Login_screen.dart';
import '../views/navbar.dart';
import '../views/profile_setting.dart';

class AuthController extends GetxController {
  var myuser = Utilisateur(nom: '', prenom: '', email: '').obs;

  // Function to authenticate user with phone number
  Future<void> phoneAuth(String telephone) async {
    try {
      // Call your backend API for phone authentication
      final response = await http.post(
        Uri.parse(AppServer.LOGIN), // Replace with your API endpoint
        headers: AppServer.headers,
        body: jsonEncode({'telephone': telephone}),
      );

      if (response.statusCode == 200) {
        log('Phone verification code sent');
      } else {
        log('Failed to send verification code');
      }
    } catch (e) {
      log("Error occurred: $e");
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp(String telephone) async {
    try {
      final response = await http.post(
        Uri.parse(AppServer.LOGIN), // Replace with your API endpoint
        headers: AppServer.headers,
        body: jsonEncode({'otp': telephone}),
      );

      if (response.statusCode == 200) {
        log("Logged in successfully");
        Get.to(() => ProfileSettingScreen());
      } else {
        log('Failed to verify OTP');
      }
    } catch (e) {
      log("Error occurred: $e");
    }
  }

  // Decide the route based on user login status
  Future<void> decideRoute() async {
    // Check if user is logged in (you may want to check with your backend)
    final response = await http.get(Uri.parse(AppServer.UTILISATEUR)); // Replace with your API endpoint
    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      if (userData != null) {
        myuser.value = Utilisateur.fromJson(userData);
        Get.to(() => NavBar());
      } else {
        Get.to(() => LoginScreen());
      }
    }
  }

  // Fetch user information from your backend
  Future<void> getUser() async {
    final response = await http.get(Uri.parse(AppServer.UTILISATEUR)); // Replace with your API endpoint
    if (response.statusCode == 200) {
      myuser.value = Utilisateur.fromJson(jsonDecode(response.body));
    }
  }

  // Function to sign out
  Future<void> signOut() async {
    await http.post(Uri.parse(AppServer.UTILISATEUR)); // Replace with your API endpoint
    Get.offAll(() => LoginScreen()); // Redirect to login screen
  }
}