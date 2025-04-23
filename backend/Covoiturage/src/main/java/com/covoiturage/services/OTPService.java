package com.covoiturage.services;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Utilisateur;
import com.covoiturage.repos.UtilisateurRepos;

@Service
public class OTPService {
    @Autowired
    private UtilisateurRepos utilisateurRepos; // Assure-toi d'avoir un repository pour Utilisateur

    private final Random random = new Random();

    public String generateOtp(String telephone) {
        String otp = String.format("%06d", random.nextInt(999999));
        Utilisateur user = utilisateurRepos.findByTelephone(telephone);
        if (user != null) {
            user.setOtp(otp);
            user.setOtpExpiration(Date.from(Instant.now().plus(5, ChronoUnit.MINUTES))); // Expiration dans 5 minutes
            utilisateurRepos.save(user);
            // Envoie l'OTP par SMS ici (via Twilio ou un autre service)
            return otp;
        }
        return null; // Gérer l'utilisateur non trouvé
    }

    public boolean validateOtp(String telephone, String otp) {
        Utilisateur user = utilisateurRepos.findByTelephone(telephone);
        return user != null && otp.equals(user.getOtp()) && 
               user.getOtpExpiration().after(new Date());
    }
}
