package com.covoiturage.repos;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.covoiturage.entities.Avis;


@Repository
public interface AvisRepos extends JpaRepository<Avis, Integer> {

    Optional<Avis> findById(Integer avisId);
    void deleteById(Integer avisId);
}
