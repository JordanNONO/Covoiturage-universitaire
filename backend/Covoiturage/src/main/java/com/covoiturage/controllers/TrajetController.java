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

import com.covoiturage.entities.Trajet;
import com.covoiturage.services.TrajetService;

@RestController
@CrossOrigin("*")
@RequestMapping("/trajet")
public class TrajetController {
    @Autowired
    private TrajetService trajetService;

    @PostMapping
    public ResponseEntity<?> save(@RequestBody Trajet trajet) {
        Trajet res = trajetService.saveOrUpdate(trajet);
        if (res == null) {
            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(res, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<?> getAll() {
        return new ResponseEntity<>(trajetService.getAll(), HttpStatus.OK);
    }

    @GetMapping("/{trajetId}")
    public ResponseEntity<?> getById(@PathVariable("trajetId") String trajetId) {
        try {
            Trajet trajet = trajetService.getById(trajetId);
            return new ResponseEntity<>(trajet, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun trajet trouvé avec l'ID : " + trajetId, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{trajetId}")
    public ResponseEntity<String> delete(@PathVariable("trajetId") String trajetId) {
        try {
            trajetService.delete(trajetId);
            return new ResponseEntity<>("Trajet supprimé avec succès", HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun trajet trouvé avec l'ID : " + trajetId, HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}