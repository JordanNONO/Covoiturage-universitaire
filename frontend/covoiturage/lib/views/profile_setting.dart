import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants/colors.dart';
import '../constants/server.dart';
import 'navbar.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  // Form verification
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.4,
              child: Stack(
                children: [
                  // Replace with your intro widget
                  Container(color: appcolor), // Placeholder for greenIntroWidget
                  Align(
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget('Nom', Icons.person_outlined, nameController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ nom est obligatoire";
                      }
                      if (input.length < 3) {
                        return "Le nom doit contenir au moins 3 caractères";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Prénom', Icons.person_outlined, homeController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ prénom est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Ville de résidence', Icons.home_outlined, businessController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ ville de résidence est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Téléphone', Icons.phone, telController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ téléphone est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Email', Icons.email, emailController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ email est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    SizedBox(height: 30),
                    isLoading
                        ? CircularProgressIndicator()
                        : greenButton('Enregistrer', () {
                      if (formKey.currentState!.validate()) {
                        storeUserInfo();
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> storeUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(AppServer.UTILISATEUR),// Replace with your API endpoint
          headers: AppServer.headers,
        body: jsonEncode({
          'nom': nameController.text,
          'prenom': homeController.text,
          'adresse': businessController.text,
          'telephone': telController.text,
          'email': emailController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful registration
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => NavBar()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Utilisateur ajouté avec succès'),
        ));
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Échec de l\'ajout de l\'utilisateur'),
        ));
      }
    } catch (e) {
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Une erreur est survenue.'),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

Widget TextFieldWidget(String title, IconData iconData, TextEditingController controller, Function validator) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      const SizedBox(height: 6),
      Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 1, blurRadius: 1),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          validator: (input) => validator(input),
          controller: controller,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(iconData, color: appcolor),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

Widget greenButton(String title, Function onPressed) {
  return MaterialButton(
    minWidth: Get.width,
    height: 50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: appcolor,
    onPressed: () => onPressed(),
    child: Text(
      title,
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}