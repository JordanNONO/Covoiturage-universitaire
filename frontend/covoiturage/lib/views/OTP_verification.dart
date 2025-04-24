import 'dart:convert';
import 'package:covoiturage/constants/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../widgets/green_intro_wiget.dart';
import '../widgets/text_wiget.dart';


class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OtpVerificationScreen(this.phoneNumber);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Optionally send an OTP via your backend here
  }

  Future<void> verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(AppServer.UTILISATEUR), // Replace with your API endpoint
      headers: AppServer.headers,
      body: jsonEncode({
        'phoneNumber': widget.phoneNumber,
        'otp': _otpController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful OTP verification
      Get.toNamed('/home'); // Navigate to home screen after successful verification
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP verification failed. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                greenIntrWigget(),
                Positioned(
                  top: 60,
                  left: 30,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.green, size: 22),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWiget(text: AppConstants.phoneVerification),
                  textWiget(
                    text: AppConstants.enterOtp,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(height: 40),
             //     PinputWidget(controller: _otpController), // Custom widget for OTP input
                  SizedBox(height: 20),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: verifyOtp,
                    child: Text('Verify OTP'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                  SizedBox(height: 20),
                  //Countdown(), // Optional countdown widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}