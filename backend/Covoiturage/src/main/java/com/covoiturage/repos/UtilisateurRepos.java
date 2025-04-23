package com.covoiturage.repos;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.covoiturage.entities.Utilisateur;

@Repository
public interface UtilisateurRepos extends JpaRepository<Utilisateur, String> {
	
	@Query("SELECT u FROM Utilisateur u WHERE u.nom LIKE %:label%")
	List<Utilisateur> searchByNomUtilisateur(@Param("label") String label);
	Utilisateur findByTelephone(String telephone);

}
