package com.covoiturage.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.covoiturage.DTOConnexion.LoginUserDto;
import com.covoiturage.entities.Utilisateur;
import com.covoiturage.repos.UtilisateurRepos;

@RestController
@RequestMapping("/auth")
@CrossOrigin("*")
public class AuthController {
    @Autowired
    UtilisateurRepos repos;

    @PostMapping(value = "/login", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> login(@RequestBody LoginUserDto nom) {
        Optional<Utilisateur> userOpt = repos.findBynom(nom.getNom());
        if (userOpt.isPresent()) {
            Utilisateur user = userOpt.get();
            if (user.getMotDePasse().equals(nom.getMotDePasse())) {
                return ResponseEntity.ok().body(user);
            }
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Echec d'Authentification");
    }
}
