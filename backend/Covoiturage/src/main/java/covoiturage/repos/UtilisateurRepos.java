package covoiturage.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import covoiturage.entities.Utilisateur;

public interface UtilisateurRepos extends JpaRepository<Utilisateur, String> {

}
