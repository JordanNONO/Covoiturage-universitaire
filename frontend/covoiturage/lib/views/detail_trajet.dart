import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../constants/colors.dart';
import '../../constants/server.dart'; // Assurez-vous d'importer votre fichier de constantes pour l'URL de l'API

class DetailTrajet extends StatefulWidget {
  const DetailTrajet({Key? key}) : super(key: key);

  @override
  State<DetailTrajet> createState() => _CreateTrajetState();
}

class _CreateTrajetState extends State<DetailTrajet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController departController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController dateHeureDepartController = TextEditingController();
  TextEditingController tarifController = TextEditingController();
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/r.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Text(
                  "Créer un trajet",
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget('Ville de départ', Icons.villa_rounded, departController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      if (input.length < 3) {
                        return "Le nom doit contenir au moins 3 caractères";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Ville d\'arrivée', Icons.villa_rounded, destinationController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Date et Heure de départ', Icons.timelapse_sharp, dateHeureDepartController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    TextFieldWidget('Tarif', Icons.price_change, tarifController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 30),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : greenButton('Enregistrer', () {
                      if (formKey.currentState!.validate()) {
                        saveTrajetInfo();
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

  Future<void> saveTrajetInfo() async {
    setState(() {
      isLoading = true;
    });

    showDialog(context: context, builder: (context) {
      return Center(child: CircularProgressIndicator());
    });

    final response = await http.post(
      Uri.parse('${AppServer.TRAJET}'), // Remplacez par votre endpoint
      headers: AppServer.headers,
      body: jsonEncode({
        'depart': departController.text,
        'destination': destinationController.text,
        'dateHeureDepart': dateHeureDepartController.text,
        'tarif': double.tryParse(tarifController.text), // Assurez-vous que le tarif est un double
        // Ajoutez d'autres propriétés si nécessaire
      }),
    );

    Navigator.pop(context);

    if (response.statusCode == 201) {
      departController.clear();
      destinationController.clear();
      dateHeureDepartController.clear();
      tarifController.clear();
      _successMessage(context);
    } else {
      // Gérer l'erreur ici
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur lors de la création du trajet"),
        backgroundColor: Colors.red,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget TextFieldWidget(String title, IconData iconData, TextEditingController controller, Function validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xffA7A7A7)),
        ),
        const SizedBox(height: 6),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 1, blurRadius: 1)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (input) => validator(input),
            controller: controller,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xffA7A7A7)),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(iconData, color: Colors.green),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(8),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(children: [
            Icon(Icons.check_circle, color: Colors.white, size: 40),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Succès", style: GoogleFonts.poppins()),
                  Spacer(),
                  Text("Trajet créé avec succès!", style: GoogleFonts.poppins()),
                ],
              ),
            ),
          ]),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 4),
        dismissDirection: DismissDirection.vertical,
      ),
    );
  }

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.green,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}