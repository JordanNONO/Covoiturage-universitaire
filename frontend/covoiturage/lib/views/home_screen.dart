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
  GoogleMapController? myMapController;
  LatLng? _currentPosition;
  bool _isLoading = true;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _getUserLocation();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.text');
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(CamerounDoualaLatitude, CamerounDoualaLongitude),
    zoom: 14.4746,
  );

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Activez la localisation pour continuer")),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Permission refusée")),
            );
          }
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _markers = {
            Marker(
              markerId: const MarkerId("current_location"),
              position: _currentPosition!,
              infoWindow: const InfoWindow(title: "Votre position"),
            )
          };
          _isLoading = false;
        });

        if (myMapController != null) {
          myMapController!.animateCamera(
            CameraUpdate.newLatLng(_currentPosition!),
          );
        }
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              icon: Image(image: AssetImage(userIcon)),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: const DrawerNavigator(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildInfoCard(),
                    const SizedBox(height: 15),
                    _buildMap(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Vous pouvez réserver en :",
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

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor1,
        boxShadow: [
          BoxShadow(
            color: appcolor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(image: AssetImage(calender), width: 60, height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Le confort de nos passagers est notre priorité",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
                myMapController?.setMapStyle(_mapStyle);
              },
              initialCameraPosition: _kGooglePlex,
              markers: _markers,
            ),
            _buildCurrentLocation(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocation() {
    return Positioned(
      right: 10,
      bottom: 10,
      child: Material(
        borderRadius: BorderRadius.circular(24),
        elevation: 4,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: appcolor,
          child: IconButton(
            icon: const Icon(Icons.my_location, color: Colors.white, size: 20),
            onPressed: _getUserLocation,
          ),
        ),
      ),
    );
  }

  Widget _buildReservationOptions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            _buildReservationOption("Business", 'assets/business.png'),
            const SizedBox(width: 25),
            _buildReservationOption("Master", 'assets/vip.png'),
            const SizedBox(width: 25),
            _buildReservationOption("Premium", null, icon: Icons.star),
            const SizedBox(width: 15),
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
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null
                  ? Icon(icon, size: 30, color: appcolor)
                  : Image(image: AssetImage(imagePath!), width: 30, height: 30),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
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