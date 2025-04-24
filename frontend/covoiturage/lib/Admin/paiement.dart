import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covoiturage/constants/colors.dart';

import '../../constants/colors.dart';
import '../../constants/server.dart';

class PaiementTicket extends StatefulWidget {
  const PaiementTicket({Key? key}) : super(key: key);

  @override
  State<PaiementTicket> createState() => _PaiementTicketState();
}

class _PaiementTicketState extends State<PaiementTicket> {
  bool _isLoading = false;

  Future<void> finalizeReservation() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
        Uri.parse(AppServer.PAIEMENT), // Replace with your payment API endpoint
        headers: AppServer.headers,
      body: jsonEncode({
        // Include necessary payment details here
        'amount': 1000, // Example amount
        'ticketId': 'your_ticket_id', // Replace with actual ticket ID
        // Add other required fields
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful payment
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Paiement réussi!'),
        backgroundColor: Colors.green,
      ));
      // Navigate to another screen or perform other actions
    } else {
      // Handle payment failure
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Échec du paiement. Veuillez réessayer.'),
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
      appBar: AppBar(
        title: Text("Paiement"),
        centerTitle: true,
        backgroundColor: appcolor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Finaliser la réservation"),
          ),
          const SizedBox(height: 20),
          _isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: finalizeReservation,
            child: Text("Payer"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appcolor),
            ),
          ),
        ],
      ),
    );
  }
}