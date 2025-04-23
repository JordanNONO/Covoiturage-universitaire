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

import com.covoiturage.entities.Messagerie;
import com.covoiturage.services.MessagerieService;

@RestController
@CrossOrigin("*")
@RequestMapping("/messagerie")
public class MessagerieController {
	    @Autowired
	    private MessagerieService messagerieService;

	    @PostMapping
	    public ResponseEntity<?> save(@RequestBody Messagerie m) {
	        Messagerie res = messagerieService.saveOrUpdate(m);
	        if (res == null) {
	            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	        return new ResponseEntity<>(res, HttpStatus.CREATED);
	    }
	    
	    @GetMapping
	    public ResponseEntity<?> getAll() {
	        return new ResponseEntity<>(messagerieService.getAll(), HttpStatus.OK);
	    }
	    
	    @GetMapping("/{messageId}")
	    public ResponseEntity<?> getById(@PathVariable("messageId") Integer messageId) {
	        try {
	            Messagerie message = messagerieService.getById(messageId);
	            return new ResponseEntity<>(message, HttpStatus.OK);
	        } catch (NoSuchElementException e) {
	            return new ResponseEntity<>("Aucun message trouvé avec l'ID : " + messageId, HttpStatus.NOT_FOUND);
	        }
	    }

	    @DeleteMapping("/{messageId}")
	    public ResponseEntity<String> delete(@PathVariable("messageId") Integer messageId) {
	        try {
	            messagerieService.delete(messageId);
	            return new ResponseEntity<>("Message supprimé avec succès", HttpStatus.NO_CONTENT);
	        } catch (NoSuchElementException e) {
	            return new ResponseEntity<>("Aucun message trouvé avec l'ID : " + messageId, HttpStatus.NOT_FOUND);
	        } catch (Exception e) {
	            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
	    
	    @GetMapping("/user/{utilisateurId}")
	    public ResponseEntity<?> findByUtilisateurId(@PathVariable("utilisateurId") String utilisateurId) {
	        return new ResponseEntity<>(messagerieService.findByUtilisateurId(utilisateurId), HttpStatus.OK);
	    }
}
