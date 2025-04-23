package com.covoiturage.repos;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.covoiturage.entities.Messagerie;

@Repository
public interface MessagerieRepos extends JpaRepository<Messagerie, Integer> {


    Optional<Messagerie> findById(Integer messageId);
    void deleteById(Integer messageId);
    List<Messagerie> findByUtilisateurId(String utilisateurId);
}
