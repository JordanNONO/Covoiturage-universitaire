package com.covoiturage.services;

import java.util.Collection;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Paiement;
import com.covoiturage.entities.Reservation;
import com.covoiturage.repos.ReservationRepos;

@Service
public class ReservationService {
	    
	    @Autowired
	    private ReservationRepos reservationRepos;

	    public Reservation saveOrUpdate(Reservation r) {
	        if (r.getUtilisateurId() != null && r.getTrajetId() != null && r.getDateReservation() !=null && r.getModePaiement() !=null) {
	            return reservationRepos.save(r);
	        }
	        return null;
	    }
	    
	    public List<Reservation> getAll() {
	        return reservationRepos.findAll();
	    }
	    
	    public Reservation getById(String reservationId) {
	        Optional<Reservation> r = reservationRepos.findById(reservationId);
	        if (r.isPresent()) {
	            return r.get();
	        }
	        throw new NoSuchElementException("Aucune réservation trouvée avec l'ID : " + reservationId);
	    }

	    public Reservation delete(String reservationId) {
	        Optional<Reservation> r = reservationRepos.findById(reservationId);
	        if (r.isPresent()) {
	            reservationRepos.deleteById(reservationId);
	            return r.get();
	        }
	        throw new NoSuchElementException("Aucune réservation trouvée avec l'ID : " + reservationId);
	    }

	    public Collection<Paiement> getPaiements(String reservationId) {
	        return getById(reservationId).getPaiementCollection();
	    }
}
