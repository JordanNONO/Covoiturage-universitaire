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

import com.covoiturage.entities.Vehicule;
import com.covoiturage.services.VehiculeService;

@RestController
@CrossOrigin("*")
@RequestMapping("/vehicule")
public class VehiculeController {
    @Autowired
    private VehiculeService vehiculeService;

    @PostMapping
    public ResponseEntity<?> save(@RequestBody Vehicule vehicule) {
        Vehicule res = vehiculeService.saveOrUpdate(vehicule);
        if (res == null) {
            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(res, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<?> getAll() {
        return new ResponseEntity<>(vehiculeService.getAll(), HttpStatus.OK);
    }

    @GetMapping("/{vehiculeId}")
    public ResponseEntity<?> getById(@PathVariable("vehiculeId") String vehiculeId) {
        try {
            Vehicule vehicule = vehiculeService.getById(vehiculeId);
            return new ResponseEntity<>(vehicule, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun véhicule trouvé avec l'ID : " + vehiculeId, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{vehiculeId}")
    public ResponseEntity<String> delete(@PathVariable("vehiculeId") String vehiculeId) {
        try {
            vehiculeService.delete(vehiculeId);
            return new ResponseEntity<>("Véhicule supprimé avec succès", HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun véhicule trouvé avec l'ID : " + vehiculeId, HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}

