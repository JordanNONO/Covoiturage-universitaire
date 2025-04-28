package com.covoiturage.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Trajet;
import com.covoiturage.entities.Utilisateur;
import com.covoiturage.repos.TrajetRepos;
import com.covoiturage.repos.UtilisateurRepos; // Importez le repository Utilisateur

@Service
public class TrajetService {

	   @Autowired
	    private TrajetRepos trajetRepos;

	    @Autowired
	    private UtilisateurRepos utilisateurRepos; // Injection du repository Utilisateur

	    public Trajet saveOrUpdate(Trajet t, String utilisateurId) {
	        // Vérification des données obligatoires et de l'ID de l'utilisateur
	        if (t.getDepart() != null && t.getDestination() != null && t.getDateHeureDepart() != null &&
	                t.getPlacesDisponibles() != null && t.getTarif() != null &&
	                utilisateurId != null && !utilisateurId.isEmpty()) {

	            // Récupération de l'utilisateur à partir de la base de données
	            Optional<Utilisateur> utilisateurOptional = utilisateurRepos.findById(utilisateurId);

	            // Vérification si l'utilisateur existe
	            if (utilisateurOptional.isPresent()) {
	                // Association de l'utilisateur au trajet
	                t.setUtilisateurIdAsso5(utilisateurOptional.get());
	                // Enregistrement ou mise à jour du trajet
	                return trajetRepos.save(t);
	            } else {
	                // Lancement d'une exception si l'utilisateur n'est pas trouvé
	                throw new NoSuchElementException("Aucun utilisateur trouvé avec l'ID : " + utilisateurId);
	            }
	        } else {
	            // Retourne null si des données obligatoires sont manquantes
	            return null; // Vous pouvez également lancer une exception ici
	        }
	    }

    public List<Trajet> getAll() {
        return trajetRepos.findAll();
    }

    public Trajet getById(Integer trajetId) {
        Optional<Trajet> t = trajetRepos.findById(trajetId);
        if (t.isPresent()) {
            return t.get();
        }
        throw new NoSuchElementException("Aucun trajet trouvé avec l'ID : " + trajetId);
    }

    public Trajet delete(Integer trajetId) {
        Optional<Trajet> t = trajetRepos.findById(trajetId);
        if (t.isPresent()) {
            trajetRepos.deleteById(trajetId);
            return t.get();
        }
        throw new NoSuchElementException("Aucun trajet trouvé avec l'ID : " + trajetId);
    }
}