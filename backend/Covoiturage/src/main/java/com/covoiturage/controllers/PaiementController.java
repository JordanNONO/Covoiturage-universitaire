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

import com.covoiturage.entities.Paiement;
import com.covoiturage.services.PaiementService;

@RestController
@CrossOrigin("*")
@RequestMapping("/paiement")
public class PaiementController {
    @Autowired
    private PaiementService paiementService;

    @PostMapping
    public ResponseEntity<?> save(@RequestBody Paiement paiement) {
        Paiement res = paiementService.saveOrUpdate(paiement);
        if (res == null) {
            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(res, HttpStatus.CREATED);
    }
    
    @GetMapping
    public ResponseEntity<?> getAll() {
        return new ResponseEntity<>(paiementService.getAll(), HttpStatus.OK);
    }
    
    @GetMapping("/{paiementId}")
    public ResponseEntity<?> getById(@PathVariable("paiementId") String paiementId) {
        try {
            Paiement paiement = paiementService.getById(paiementId);
            return new ResponseEntity<>(paiement, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun paiement trouvé avec l'ID : " + paiementId, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{paiementId}")
    public ResponseEntity<String> delete(@PathVariable("paiementId") String paiementId) {
        try {
            paiementService.delete(paiementId);
            return new ResponseEntity<>("Paiement supprimé avec succès", HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun paiement trouvé avec l'ID : " + paiementId, HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}