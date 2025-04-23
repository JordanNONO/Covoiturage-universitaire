package com.covoiturage.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Vehicule;
import com.covoiturage.repos.VehiculeRepos;

@Service
public class VehiculeService {
	    
	    @Autowired
	    private VehiculeRepos vehiculeRepos;

	    public Vehicule saveOrUpdate(Vehicule v) {
	        if (v.getMarque() != null && v.getModele() != null && v.getImmatriculation() != null && v.getPlacesDisponibles() !=null && v.getTrajetId()!=null && v.getUtilisateurId() !=null && v.getCouleur() !=null && v.getModele()!=null ) {
	            return vehiculeRepos.save(v);
	        }
	        return null;
	    }
	    
	    public List<Vehicule> getAll() {
	        return vehiculeRepos.findAll();
	    }
	    
	    public Vehicule getById(String vehiculeId) {
	        Optional<Vehicule> v = vehiculeRepos.findById(vehiculeId);
	        if (v.isPresent()) {
	            return v.get();
	        }
	        throw new NoSuchElementException("Aucun véhicule trouvé avec l'ID : " + vehiculeId);
	    }

	    public Vehicule delete(String vehiculeId) {
	        Optional<Vehicule> v = vehiculeRepos.findById(vehiculeId);
	        if (v.isPresent()) {
	            vehiculeRepos.deleteById(vehiculeId);
	            return v.get();
	        }
	        throw new NoSuchElementException("Aucun véhicule trouvé avec l'ID : " + vehiculeId);
	    }
}
