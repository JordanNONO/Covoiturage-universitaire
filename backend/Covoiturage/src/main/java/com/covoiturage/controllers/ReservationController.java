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

import com.covoiturage.entities.Reservation;
import com.covoiturage.services.ReservationService;

@RestController
@CrossOrigin("*")
@RequestMapping("/reservation")
public class ReservationController {
	    @Autowired
	    private ReservationService reservationService;

	    @PostMapping
	    public ResponseEntity<?> save(@RequestBody Reservation reservation) {
	        Reservation res = reservationService.saveOrUpdate(reservation);
	        if (res == null) {
	            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	        return new ResponseEntity<>(res, HttpStatus.CREATED);
	    }

	    @GetMapping
	    public ResponseEntity<?> getAll() {
	        return new ResponseEntity<>(reservationService.getAll(), HttpStatus.OK);
	    }

	    @GetMapping("/{reservationId}")
	    public ResponseEntity<?> getById(@PathVariable("reservationId") String reservationId) {
	        try {
	            Reservation reservation = reservationService.getById(reservationId);
	            return new ResponseEntity<>(reservation, HttpStatus.OK);
	        } catch (NoSuchElementException e) {
	            return new ResponseEntity<>("Aucune réservation trouvée avec l'ID : " + reservationId, HttpStatus.NOT_FOUND);
	        }
	    }

	    @DeleteMapping("/{reservationId}")
	    public ResponseEntity<String> delete(@PathVariable("reservationId") String reservationId) {
	        try {
	            reservationService.delete(reservationId);
	            return new ResponseEntity<>("Réservation supprimée avec succès", HttpStatus.NO_CONTENT);
	        } catch (NoSuchElementException e) {
	            return new ResponseEntity<>("Aucune réservation trouvée avec l'ID : " + reservationId, HttpStatus.NOT_FOUND);
	        } catch (Exception e) {
	            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
}
