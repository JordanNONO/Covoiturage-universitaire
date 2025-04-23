package com.covoiturage.controllers;

import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.covoiturage.entities.Utilisateur;
import com.covoiturage.services.UtilisateurService;

@RestController
@CrossOrigin("*")
@RequestMapping("/utilisateur")
public class UtilisateurController {
    @Autowired
    private UtilisateurService utilisateurService;

    @PostMapping
    public ResponseEntity<?> save(@RequestBody Utilisateur utilisateur) {
        Utilisateur res = utilisateurService.saveOrUpdate(utilisateur);
        if (res == null) {
            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(res, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<?> getAll() {
        return new ResponseEntity<>(utilisateurService.getAll(), HttpStatus.OK);
    }

    @GetMapping("/{utilisateurId}")
    public ResponseEntity<?> getById(@PathVariable("utilisateurId") String utilisateurId) {
        try {
            Utilisateur utilisateur = utilisateurService.getById(utilisateurId);
            return new ResponseEntity<>(utilisateur, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun utilisateur trouvé avec l'ID : " + utilisateurId, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{utilisateurId}")
    public ResponseEntity<String> delete(@PathVariable("utilisateurId") String utilisateurId) {
        try {
            utilisateurService.delete(utilisateurId);
            return new ResponseEntity<>("Utilisateur supprimé avec succès", HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun utilisateur trouvé avec l'ID : " + utilisateurId, HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}