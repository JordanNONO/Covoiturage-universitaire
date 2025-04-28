package com.covoiturage.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Utilisateur;
import com.covoiturage.repos.UtilisateurRepos;

@Service
public class UtilisateurService {
    @Autowired
    private UtilisateurRepos utilisateurRepos;

    public Utilisateur saveOrUpdate(Utilisateur u) {
        if (u.getNom() != null && u.getPrenom() !=null && u.getEmail() != null && u.getMotDePasse() != null && u.getPhotoProfil() != null  && u.getTelephone() != null ) {
            return utilisateurRepos.save(u);
        }
        return null;
    }

    public List<Utilisateur> getAll() {
        return utilisateurRepos.findAll();
    }

    public Utilisateur getById(String utilisateurId) {
        Optional<Utilisateur> u = utilisateurRepos.findById(utilisateurId);
        if (u.isPresent()) {
            return u.get();
        }
        throw new NoSuchElementException("Aucun utilisateur trouvé avec l'ID : " + utilisateurId);
    }

    public Utilisateur delete(String utilisateurId) {
        Optional<Utilisateur> u = utilisateurRepos.findById(utilisateurId);
        if (u.isPresent()) {
            utilisateurRepos.deleteById(utilisateurId);
            return u.get();
        }
        throw new NoSuchElementException("Aucun utilisateur trouvé avec l'ID : " + utilisateurId);
    }

//	    public Collection<Trajet> getTrajets(String utilisateurId) {
//	        return getById(utilisateurId).getTrajetCollection();
//	    }
//
//	    public Collection<Avis> getAvis(String utilisateurId) {
//	        return getById(utilisateurId).getAvisCollection();
//	    }
//
//	    public Collection<Role> getRoles(String utilisateurId) {
//	        return getById(utilisateurId).getRoleCollection();
//	    }
//
//	    public Collection<Vehicule> getVehicules(String utilisateurId) {
//	        return getById(utilisateurId).getVehiculeCollection();
//	    }
//
//	    public Collection<Reservation> getReservations(String utilisateurId) {
//	        return getById(utilisateurId).getReservationCollection();
//	    }
//
//	    public Collection<Messagerie> getMessageries(String utilisateurId) {
//	        return getById(utilisateurId).getMessagerieCollection();
//	    }
}
