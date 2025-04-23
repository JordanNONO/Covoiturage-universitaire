package com.covoiturage.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Paiement;
import com.covoiturage.repos.PaiementRepos;

@Service
public class PaiementService {

	@Autowired
    private PaiementRepos paiementRepos;

    public Paiement saveOrUpdate(Paiement p) {
        if (p.getMontant() != null && p.getMethode() != null && p.getStatut() !=null && p.getDatePaiement() !=null) {
            return paiementRepos.save(p);
        }
        return null;
    }
    
    public List<Paiement> getAll() {
        return paiementRepos.findAll();
    }
    
    public Paiement getById(String paiementId) {
        Optional<Paiement> p = paiementRepos.findById(paiementId);
        if (p.isPresent()) {
            return p.get();
        }
        throw new NoSuchElementException("Aucun paiement trouvé avec l'ID : " + paiementId);
    }

    public Paiement delete(String paiementId) {
        Optional<Paiement> p = paiementRepos.findById(paiementId);
        if (p.isPresent()) {
            paiementRepos.deleteById(paiementId);
            return p.get();
        }
        throw new NoSuchElementException("Aucun paiement trouvé avec l'ID : " + paiementId);
    }

//    public List<Paiement> findByReservationId(String reservationId) {
//        return paiementRepos.findByReservationId(reservationId);
//    }

}
