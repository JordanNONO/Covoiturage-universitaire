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

import com.covoiturage.entities.Avis;
import com.covoiturage.services.AvisService;

@RestController
@CrossOrigin("*")
@RequestMapping("/avis")
public class AvisController {

	    @Autowired
	    private AvisService avisService;

	    @PostMapping
	    public ResponseEntity<?> save(@RequestBody Avis avis) {
	        Avis res = avisService.saveOrUpdate(avis);
	        if (res == null) {
	            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	        return new ResponseEntity<>(res, HttpStatus.CREATED);
	    }
	    
	    @GetMapping
	    public ResponseEntity<?> getAll() {
	        return new ResponseEntity<>(avisService.getAll(), HttpStatus.OK);
	    }
	    
	    @GetMapping("/{avisId}")
	    public ResponseEntity<?> getById(@PathVariable("avisId") Integer avisId) {
	        try {
	            Avis avis = avisService.getById(avisId);
	            return new ResponseEntity<>(avis, HttpStatus.OK);
	        } catch (NoSuchElementException e) {
	            return new ResponseEntity<>("Aucun avis trouvé avec l'ID : " + avisId, HttpStatus.NOT_FOUND);
	        }
	    }

	    @DeleteMapping("/{avisId}")
	    public ResponseEntity<String> delete(@PathVariable("avisId") Integer avisId) {
	        try {
	            avisService.delete(avisId);
	            return new ResponseEntity<>("Avis supprimé avec succès", HttpStatus.NO_CONTENT);
	        } catch (NoSuchElementException e) {
	            return new ResponseEntity<>("Aucun avis trouvé avec l'ID : " + avisId, HttpStatus.NOT_FOUND);
	        } catch (Exception e) {
	            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
}
