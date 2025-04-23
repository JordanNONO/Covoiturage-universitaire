	package com.covoiturage.services;
	
	import java.util.List;
	import java.util.NoSuchElementException;
	import java.util.Optional;
	
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Service;
	
	import com.covoiturage.entities.Messagerie;
	import com.covoiturage.repos.MessagerieRepos;
	
	@Service
	public class MessagerieService {
		@Autowired
	    private MessagerieRepos messagerieRepos;
	
	    public Messagerie saveOrUpdate(Messagerie m) {
	        if (m.getUtilisateurId() != null && m.getContenu() != null && m.getDateEnvoi() !=null) {
	            return messagerieRepos.save(m);
	        }
	        return null;
	    }
	    
	    public List<Messagerie> getAll() {
	        return messagerieRepos.findAll();
	    }
	    
	    public Messagerie getById(Integer messageId) {
	        Optional<Messagerie> m = messagerieRepos.findById(messageId);
	        if (m.isPresent()) {
	            return m.get();
	        }
	        throw new NoSuchElementException("Aucun message trouvé avec l'ID : " + messageId);
	    }
	
	    public Messagerie delete(Integer messageId) {
	        Optional<Messagerie> m = messagerieRepos.findById(messageId);
	        if (m.isPresent()) {
	            messagerieRepos.deleteById(messageId);
	            return m.get();
	        }
	        throw new NoSuchElementException("Aucun message trouvé avec l'ID : " + messageId);
	    }
	
	    public List<Messagerie> findByUtilisateurId(String utilisateurId) {
	        return messagerieRepos.findByUtilisateurId(utilisateurId);
	    }
	}
