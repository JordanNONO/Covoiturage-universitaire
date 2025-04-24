import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/server.dart';

class OtpService {
  final String baseUrl;

  OtpService(this.baseUrl);

  Future<bool> verifyOtp(String telephone, String otp) async {
    final response = await http.post(
      Uri.parse("${AppServer.LOGIN}/$telephone"),
      headers: AppServer.headers,
      body: jsonEncode({
        'phoneNumber': telephone,
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      return true; // OTP valide
    } else {
      return false; // OTP invalide
    }
  }
}