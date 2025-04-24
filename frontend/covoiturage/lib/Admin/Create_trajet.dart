import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../constants/colors.dart';
import '../../constants/server.dart';
import '../../models/Trajet.dart';

class CreateTrajet extends StatefulWidget {
  const CreateTrajet({Key? key}) : super(key: key);

  @override
  State<CreateTrajet> createState() => _CreateTrajetState();
}

class _CreateTrajetState extends State<CreateTrajet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController QuartierDeDepartController = TextEditingController();
  TextEditingController QuartierArriverController = TextEditingController();
  TextEditingController HeurDepartController = TextEditingController();
  TextEditingController PrixController = TextEditingController();
  TextEditingController DateVoyageController = TextEditingController();

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
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/mask.png'),
                            fit: BoxFit.fill
                        )
                    ),
                    height: 250,
                    child: Center(
                      child: Text("Créer un trajet",
                        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
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
                    TextFieldWidget('Quartier depart de départ', Icons.villa_rounded, QuartierDeDepartController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      if (input.length < 3) {
                        return "Le nom doit contenir au moins 3 caractères";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Quartier d\'arrivée', Icons.villa_rounded, QuartierArriverController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 10),
                    TextFieldWidget('Heure de départ', Icons.timelapse_sharp, HeurDepartController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    TextFieldWidget('Prix', Icons.price_change, PrixController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    TextFieldWidget('Date du voyage', Icons.date_range, DateVoyageController, (String? input) {
                      if (input!.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    }),
                    SizedBox(height: 30),
                    isLoading ? Center(child: CircularProgressIndicator()) : greenButton('Enregistrer', () {
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
      Uri.parse(AppServer.TRAJET), // Remplacez par votre endpoint
      headers: AppServer.headers,
      body: jsonEncode({
        'QuartierDepart': QuartierDeDepartController.text,
        'QuartierArriver': QuartierArriverController.text,
        'heurDepart': HeurDepartController.text,
        'prix': PrixController.text,
        'dateVoyage': DateVoyageController.text,
      }),
    );

    Navigator.pop(context);

    if (response.statusCode == 201) {
      QuartierDeDepartController.clear();
      QuartierArriverController.clear();
      HeurDepartController.clear();
      PrixController.clear();
      DateVoyageController.clear();
      _successMessage(context);
    } else {
      // Gérer les erreurs ici
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Échec de la création du trajet"),
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
        Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
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

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        height: 80,
        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Icon(Icons.check_circle, color: Colors.white, size: 40),
          SizedBox(width: 20),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Succès", style: GoogleFonts.poppins()),
              Spacer(),
              Text("Trajet créé avec succès!", style: GoogleFonts.poppins()),
            ],
          )),
        ]),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: 4),
      dismissDirection: DismissDirection.vertical,
    ));
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
}