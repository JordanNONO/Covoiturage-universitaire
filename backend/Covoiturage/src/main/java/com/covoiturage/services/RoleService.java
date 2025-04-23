package com.covoiturage.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.covoiturage.entities.Role;
import com.covoiturage.repos.RoleRepos;

@Service
public class RoleService {
	    
	    @Autowired
	    private RoleRepos roleRepos;

	    public Role saveOrUpdate(Role r) {
	        if (r.getRoleName() != null && r.getRoleDesc() !=null && r.getUtilisateurId() !=null) {
	            return roleRepos.save(r);
	        }
	        return null;
	    }
	    
	    public List<Role> getAll() {
	        return roleRepos.findAll();
	    }
	    
	    public Role getById(String roleId) {
	        Optional<Role> r = roleRepos.findById(roleId);
	        if (r.isPresent()) {
	            return r.get();
	        }
	        throw new NoSuchElementException("Aucun rôle trouvé avec l'ID : " + roleId);
	    }

	    public Role delete(String roleId) {
	        Optional<Role> r = roleRepos.findById(roleId);
	        if (r.isPresent()) {
	            roleRepos.deleteById(roleId);
	            return r.get();
	        }
	        throw new NoSuchElementException("Aucun rôle trouvé avec l'ID : " + roleId);
	    }
}
