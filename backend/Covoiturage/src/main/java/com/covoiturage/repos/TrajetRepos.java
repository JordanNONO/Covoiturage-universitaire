package com.covoiturage.repos;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.covoiturage.entities.Trajet;

@Repository
public interface TrajetRepos extends JpaRepository<Trajet, Integer>  {
	void deleteById(Integer trajetId);
	 Optional findById(Integer trajetId);
}
