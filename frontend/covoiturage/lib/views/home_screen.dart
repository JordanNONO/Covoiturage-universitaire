import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/colors.dart';
import '../constants/image_string.dart';
import '../constants/possitonGeographique.dart';
import 'drawerpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _mapStyle;
  GoogleMapController? _mapController; // Renommage pour la clarté
  LatLng? _currentPosition;
  bool _isLoading = true;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _loadMapStyle();
    await _getUserLocation();
    setState(() {});
  }

  Future<void> _loadMapStyle() async {
    try {
      _mapStyle = await rootBundle.loadString('assets/map_style.txt');
      if (_mapController != null) {
        _mapController!.setMapStyle(_mapStyle);
      }
    } catch (e) {
      debugPrint('Erreur lors du chargement du style de la carte: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Impossible de charger le style de la carte")),
        );
      }
    }
  }

  final CameraPosition _initialCameraPosition = CameraPosition( // Renommage pour la clarté
    target: LatLng(CamerounDoualaLatitude, CamerounDoualaLongitude),
    zoom: 14.4746,
  );

  Future<void> _getUserLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnackBar("Veuillez activer la localisation");
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackBar("La permission de localisation a été refusée");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnackBar("La permission de localisation est désactivée de façon permanente. Veuillez l'activer dans les paramètres de votre appareil.");
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _markers.add(
            Marker(
              markerId: const MarkerId("current_location"),
              position: _currentPosition!,
              infoWindow: const InfoWindow(title: "Votre position actuelle"),
            ),
          );
          _isLoading = false;
          if (_mapController != null) {
            _animateCameraToPosition(_currentPosition!);
          }
        });
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la localisation: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar("Erreur lors de la récupération de la localisation");
      }
    }
  }

  void _animateCameraToPosition(LatLng position) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const DrawerNavigator(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Utiliser toute la largeur
                  children: [
                    const SizedBox(height: 10),
                    _buildInfoCard(),
                    const SizedBox(height: 15),
                    Expanded(child: _buildMap()), // La carte prend l'espace disponible
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Choisissez votre type de réservation :",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildReservationOptions(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        "Covoiturage Universitaire",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: appcolor,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Image.asset(userIcon),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16), // Légère réduction du padding
      margin: const EdgeInsets.symmetric(horizontal: 16), // Marges légèrement réduites
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Bords légèrement plus arrondis
        color: containerColor1,
        boxShadow: [
          BoxShadow(
            color: appcolor.withOpacity(0.3), // Ombre plus subtile
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(calender, width: 50, height: 40), // Taille d'image légèrement réduite
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12), // Padding légèrement réduit
              child: Text(
                "Votre confort est notre priorité absolue.",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500, // Ajout d'un léger poids
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // Marges cohérentes
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Ombre plus légère
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (_mapStyle != null) {
                  _mapController?.setMapStyle(_mapStyle);
                }
              },
              initialCameraPosition: _initialCameraPosition,
              markers: _markers,
              myLocationEnabled: false, // Utilisation de notre propre bouton
              myLocationButtonEnabled: false, // Désactiver le bouton par défaut
            ),
            _buildCurrentLocationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      right: 12,
      bottom: 12,
      child: Material(
        borderRadius: BorderRadius.circular(28), // Plus arrondi
        elevation: 3, // Ombre légèrement réduite
        child: CircleAvatar(
          radius: 26, // Taille légèrement augmentée
          backgroundColor: appcolor,
          child: IconButton(
            icon: const Icon(Icons.my_location, color: Colors.white, size: 22), // Taille d'icône légèrement augmentée
            onPressed: _getUserLocation,
          ),
        ),
      ),
    );
  }

  Widget _buildReservationOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12), // Padding vertical légèrement réduit
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Ombre encore plus légère
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16), // Padding horizontal pour les options
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 8),
            _buildReservationOption("Business", 'assets/images/business.png'),
            const SizedBox(width: 16),
            _buildReservationOption("Master", 'assets/images/vip.png'),
            const SizedBox(width: 16),
            _buildReservationOption("Premium", null, icon: Icons.star_border),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationOption(String title, String? imagePath, {IconData? icon}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // TODO: Implementer l'action de réservation
          debugPrint("Réservation pour $title");
        },
        child: Container(
          padding: const EdgeInsets.all(12), // Padding légèrement augmenté
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(icon, size: 32, color: appcolor) // Taille d'icône légèrement augmentée
              else if (imagePath != null)
                Image.asset(imagePath, width: 32, height: 32), // Taille d'image cohérente
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, // Poids de police légèrement réduit
                  fontSize: 14,
                  color: appcolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}