import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:covoiturage/constants/colors.dart';
import 'package:covoiturage/constants/server.dart';
import 'package:covoiturage/models/Trajet.dart'; // Importez votre modèle Trajet

class CreateTrajet extends StatefulWidget {
  const CreateTrajet({Key? key}) : super(key: key);

  @override
  State<CreateTrajet> createState() => _CreateTrajetState();
}

class _CreateTrajetState extends State<CreateTrajet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Trajet _trajet = Trajet(
    depart: '',
    destination: '',
    dateHeureDepart: DateTime.now(),
    tarif: 0,
    placesDisponibles: 1,
  );

  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
                        image: AssetImage('assets/r.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Créer un trajet",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
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
                    TextFieldWidget(
                        'Ville de départ',
                        Icons.location_on,
                            (value) => _trajet.depart = value,
                            (String? input) {
                          if (input!.isEmpty) return "Le champ est obligatoire";
                          if (input.length < 3) return "Le nom doit contenir au moins 3 caractères";
                          return null;
                        },
                        initialValue: _trajet.depart
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                        'Ville d\'arrivée',
                        Icons.location_on,
                            (value) => _trajet.destination = value,
                            (String? input) {
                          if (input!.isEmpty) return "Le champ est obligatoire";
                          return null;
                        },
                        initialValue: _trajet.destination
                    ),
                    SizedBox(height: 10),
                    DatePickerWidget(
                      'Date du voyage',
                      selectedDate,
                          (newDate) {
                        setState(() {
                          selectedDate = newDate;
                          _trajet.dateHeureDepart = DateTime(
                            newDate.year,
                            newDate.month,
                            newDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TimePickerWidget(
                      'Heure de départ',
                      selectedTime,
                          (newTime) {
                        setState(() {
                          selectedTime = newTime;
                          _trajet.dateHeureDepart = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            newTime.hour,
                            newTime.minute,
                          );
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                        'Prix',
                        Icons.attach_money,
                            (value) => _trajet.tarif = double.tryParse(value) ?? 0,
                            (String? input) {
                          if (input!.isEmpty) return "Le champ est obligatoire";
                          if (double.tryParse(input) == null) return "Veuillez entrer un nombre valide";
                          return null;
                        },
                        initialValue: _trajet.tarif.toString(),
                        keyboardType: TextInputType.number
                    ),
                    TextFieldWidget(
                        'Places disponibles',
                        Icons.people,
                            (value) => _trajet.placesDisponibles = int.tryParse(value) ?? 1,
                            (String? input) {
                          if (input!.isEmpty) return "Le champ est obligatoire";
                          if (int.tryParse(input) == null) return "Veuillez entrer un nombre entier";
                          return null;
                        },
                        initialValue: _trajet.placesDisponibles.toString(),
                        keyboardType: TextInputType.number
                    ),
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

    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await http.post(
        Uri.parse('${AppServer.TRAJET}'),
        headers: AppServer.headers,
        body: jsonEncode(_trajet.toJson()), // Utilisez la méthode toJson de votre modèle
      );

      Navigator.pop(context);

      if (response.statusCode == 201) {
        _successMessage(context);
        // Réinitialiser le formulaire si nécessaire
        setState(() {
          _trajet = Trajet(
            depart: '',
            destination: '',
            dateHeureDepart: DateTime.now(),
            tarif: 0,
            placesDisponibles: 1,
          );
          selectedDate = DateTime.now();
          selectedTime = TimeOfDay.now();
        });
      } else {
        _errorMessage(context, "Erreur lors de la création du trajet: ${response.body}");
      }
    } catch (e) {
      Navigator.pop(context);
      _errorMessage(context, "Erreur de connexion: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget TextFieldWidget(
      String title,
      IconData iconData,
      Function(String) onChanged,
      FormFieldValidator<String> validator, {
        String? initialValue,
        TextInputType? keyboardType,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffA7A7A7)
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            initialValue: initialValue,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7)
            ),
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

  Widget DatePickerWidget(
      String title,
      DateTime initialDate,
      Function(DateTime) onDateSelected,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffA7A7A7)
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.green),
            title: Text(
              "${initialDate.day}/${initialDate.month}/${initialDate.year}",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffA7A7A7)
              ),
            ),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != initialDate) {
                onDateSelected(picked);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget TimePickerWidget(
      String title,
      TimeOfDay initialTime,
      Function(TimeOfDay) onTimeSelected,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffA7A7A7)
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(Icons.access_time, color: Colors.green),
            title: Text(
              initialTime.format(context),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffA7A7A7)
              ),
            ),
            onTap: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: initialTime,
              );
              if (picked != null && picked != initialTime) {
                onTimeSelected(picked);
              }
            },
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
        style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    );
  }
}