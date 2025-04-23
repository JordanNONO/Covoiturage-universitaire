package com.covoiturage.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.covoiturage.services.OTPService;

@RestController
@RequestMapping("/auth")
@CrossOrigin("*") 
public class AuthController {
    @Autowired
    private OTPService otpService;

    @PostMapping("/request-otp")
    public ResponseEntity<String> requestOtp(@RequestParam String telephone) {
        String otp = otpService.generateOtp(telephone);
        if (otp != null) {
            return ResponseEntity.ok("OTP envoyé au numéro : " + telephone);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Utilisateur non trouvé.");
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<String> verifyOtp(@RequestParam String telephone, @RequestParam String otp) {
        boolean isValid = otpService.validateOtp(telephone, otp);
        if (isValid) {
            return ResponseEntity.ok("OTP valide !");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("OTP invalide ou expiré.");
    }
}