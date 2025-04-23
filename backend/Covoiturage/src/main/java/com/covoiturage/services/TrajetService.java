package com.covoiturage.services;

import java.util.Collection;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Trajet;
import com.covoiturage.entities.Utilisateur;
import com.covoiturage.entities.Vehicule;
import com.covoiturage.repos.TrajetRepos;

@Service
public class TrajetService {

	    @Autowired
	    private TrajetRepos trajetRepos;

	    public Trajet saveOrUpdate(Trajet t) {
	        if (t.getDepart() != null && t.getDestination() != null && t.getDateHeureDepart() != null && t.getDateHeureDepart() !=null && t.getDestination() !=null && t.getPlacesDisponibles() !=null && t.getTarif() !=null) {
	            return trajetRepos.save(t);
	        }
	        return null;
	    }
	    
	    public List<Trajet> getAll() {
	        return trajetRepos.findAll();
	    }
	    
	    public Trajet getById(String trajetId) {
	        Optional<Trajet> t = trajetRepos.findById(trajetId);
	        if (t.isPresent()) {
	            return t.get();
	        }
	        throw new NoSuchElementException("Aucun trajet trouvé avec l'ID : " + trajetId);
	    }

	    public Trajet delete(String trajetId) {
	        Optional<Trajet> t = trajetRepos.findById(trajetId);
	        if (t.isPresent()) {
	            trajetRepos.deleteById(trajetId);
	            return t.get();
	        }
	        throw new NoSuchElementException("Aucun trajet trouvé avec l'ID : " + trajetId);
	    }

	    public Collection<Utilisateur> getUtilisateurs(String trajetId) {
	        return getById(trajetId).getUtilisateurCollection();
	    }

	    public Collection<Vehicule> getVehicules(String trajetId) {
	        return getById(trajetId).getVehiculeCollection();
	    }
}
