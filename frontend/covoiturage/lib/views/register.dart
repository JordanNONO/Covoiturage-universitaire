import 'dart:typed_data';
import 'package:covoiturage/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth_service.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Uint8List? _imageData; // Stockage des données de l'image
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Méthode pour sélectionner une image
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes; // Stocker les données de l'image
        print("Image sélectionnée: ${pickedFile.path}"); // Débogage
      });
    } else {
      print("Aucune image sélectionnée.");
    }
  }

  // Méthode pour soumettre le formulaire
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authService = AuthService();
      String? photoProfil;

      // Uploader l'image si elle est sélectionnée
      if (_imageData != null) {
        photoProfil = await uploadImage(_imageData!);
        if (photoProfil == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'upload de l\'image.')),
          );
          setState(() => _isLoading = false);
          return; // Sortir si l'upload échoue
        }
      }

      // Inscription de l'utilisateur
      final result = await authService.register(
        _nomController.text,
        _prenomController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
        photoProfil ?? '', // Passer la photo ici, ou une chaîne vide si null
      );

      setState(() => _isLoading = false);

      // Afficher le résultat de l'inscription
      if (result == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inscription réussie!'),
            backgroundColor: Colors.green,
          ),
        );
        Get.to(() => LoginScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur d\'inscription, veuillez réessayer.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Méthode pour uploader l'image
  Future<String?> uploadImage(Uint8List imageData) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(AppServer.UTILISATEUR), // URL de votre API
      );
      request.files.add(http.MultipartFile.fromBytes('photo', imageData, filename: 'photo.jpg'));

      final response = await request.send();
      if (response.statusCode == 200) {
        // Remplacez par la logique pour obtenir l'URL de l'image
        return 'URL_DE_L_IMAGE'; // Placeholder, ajustez selon votre API
      } else {
        throw Exception('Échec du téléchargement de l\'image, statut: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'upload de l\'image: $e');
      return null; // Retourner null en cas d'erreur
    }
  }

  // Méthode pour afficher le dialogue de sélection d'image
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choisir une image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.green),
              title: Text('Prendre une photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.green),
              title: Text('Choisir depuis la galerie'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade800,
              Colors.green.shade600,
              Colors.green.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Rejoignez-nous',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Créez votre compte en quelques étapes',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),

              // Carte de formulaire
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Avatar avec téléversement d'image
                      GestureDetector(
                        onTap: () => _showImagePickerDialog(),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.green.shade100,
                              backgroundImage: _imageData != null
                                  ? MemoryImage(_imageData!)
                                  : null,
                              child: _imageData == null
                                  ? Icon(Icons.person, size: 50, color: Colors.green)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.camera_alt, size: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Champs de formulaire
                      _buildInputField(
                        controller: _nomController,
                        label: 'Nom',
                        icon: Icons.person_outline,
                        validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                      ),
                      SizedBox(height: 15),

                      _buildInputField(
                        controller: _prenomController,
                        label: 'Prénom',
                        icon: Icons.person_outline,
                        validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                      ),
                      SizedBox(height: 15),

                      _buildInputField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) return 'Email requis';
                          if (!value.contains('@')) return 'Email invalide';
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      _buildPasswordField(),
                      SizedBox(height: 15),

                      _buildInputField(
                        controller: _phoneController,
                        label: 'Téléphone',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 25),

                      // Bouton d'inscription
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          onPressed: _isLoading ? null : _submitForm,
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                            'S\'INSCRIRE',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Lien vers connexion
              TextButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Déjà un compte? ',
                    style: GoogleFonts.poppins(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Connectez-vous',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour construire un champ de texte
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  // Méthode pour construire un champ de mot de passe
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        prefixIcon: Icon(Icons.lock_outline, color: Colors.green),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.green,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Mot de passe requis';
        if (value.length < 6) return '6 caractères minimum';
        return null;
      },
    );
  }
}