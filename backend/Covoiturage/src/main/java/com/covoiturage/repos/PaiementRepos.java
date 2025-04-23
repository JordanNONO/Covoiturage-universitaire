package com.covoiturage.repos;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.covoiturage.entities.Paiement;

@Repository
public interface PaiementRepos extends JpaRepository<Paiement, String> {
//    List<Paiement> findByReservationId(String utilisateurId);
    
}
	