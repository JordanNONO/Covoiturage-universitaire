import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../models/Utilisateur.dart';
import '../services/utilisateur_service.dart';
import 'navbar.dart';

class ProfileSettingScreen extends StatefulWidget {
  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Uint8List? _imageData; // Store image data
  bool _isLoading = false;
  bool _obscurePassword = true;
  final UtilisateurService _utilisateurService = UtilisateurService();
  Utilisateur? _utilisateur;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when screen initializes
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Fetch user data from service
      _utilisateur = await _utilisateurService.getAll().then((list) => list.first); // Get the first user for demonstration
      setState(() {
        _nomController.text = _utilisateur?.nom ?? '';
        _prenomController.text = _utilisateur?.prenom ?? '';
        _emailController.text = _utilisateur?.email ?? '';
        _phoneController.text = _utilisateur?.telephone ?? '';
        // Load image if available
        _imageData = _utilisateur?.photoProfil != null ? base64Decode(_utilisateur!.photoProfil!) : null;
      });
    } catch (e) {
      print('Error loading user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des données.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes; // Store image data
      });
    }
  }

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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Create a new Utilisateur object
      Utilisateur updatedUser = Utilisateur(
        utilisateurId: _utilisateur?.utilisateurId,
        nom: _nomController.text,
        prenom: _prenomController.text,
        email: _emailController.text,
        motDePasse: _passwordController.text,
        telephone: _phoneController.text,
        photoProfil: _imageData != null ? base64Encode(_imageData!) : null, // Convert image to base64
      );

      try {
        // Update user details
        await _utilisateurService.update(updatedUser.utilisateurId!, updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mise à jour réussie!'),
            backgroundColor: Colors.green,
          ),
        );
        Get.to(() => NavBar());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de mise à jour, veuillez réessayer.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
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
                'Modifier votre profil',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Mettez à jour vos informations',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),

              // Form card
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
                      // Avatar with image upload
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

                      // Input fields
                      _buildInputField(
                        controller: _nomController,
                        label: 'Nom',
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: 15),

                      _buildInputField(
                        controller: _prenomController,
                        label: 'Prénom',
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: 15),

                      _buildInputField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
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

                      // Update button
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
                            'MISE À JOUR',
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
            ],
          ),
        ),
      ),
    );
  }

  // Method to build an input field
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ce champ est requis';
        }
        return null;
      },
    );
  }

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