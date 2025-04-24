import 'dart:ffi';

import 'package:covoiturage/widgets/pinput_widget.dart';
import 'package:covoiturage/widgets/text_wiget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


import '../constants/app_constants.dart';
import '../views/otp_verification.dart';

Widget  OptVerificationWidget() {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWiget(text: AppConstants.phoneVerification),
            textWiget(
                text: AppConstants.enterOtp,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            SizedBox(
              height: 40,
            ),
            RoundedWithShadow(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

            )
          ],
        ),
      );
}
