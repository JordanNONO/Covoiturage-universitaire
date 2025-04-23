package com.covoiturage.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Avis;
import com.covoiturage.repos.AvisRepos;

@Service
public class AvisService {
	    @Autowired
	    private AvisRepos avisRepos;

	    public Avis saveOrUpdate(Avis a) {
	        if (a.getNote() != null && a.getUtilisateurId() != null && a.getCommentaire() !=null && a.getDateAvis() !=null) {
	            return avisRepos.save(a);
	        }
	        return null;
	    }
	    
	    public List<Avis> getAll() {
	        return avisRepos.findAll();
	    }
	    
	    public Avis getById(Integer avisId) {
	        Optional<Avis> a = avisRepos.findById(avisId);
	        if (a.isPresent()) {
	            return a.get();
	        }
	        throw new NoSuchElementException("Aucun avis trouvé avec l'ID : " + avisId);
	    }

	    public Avis delete(Integer avisId) {
	        Optional<Avis> a = avisRepos.findById(avisId);
	        if (a.isPresent()) {
	            avisRepos.deleteById(avisId);
	            return a.get();
	        }
	        throw new NoSuchElementException("Aucun avis trouvé avec l'ID : " + avisId);
	    }
}
