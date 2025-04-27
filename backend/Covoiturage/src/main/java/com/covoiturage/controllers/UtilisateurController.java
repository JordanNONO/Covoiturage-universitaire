package com.covoiturage.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.covoiturage.entities.Utilisateur;
import com.covoiturage.services.UtilisateurService;

@RestController
@RequestMapping("/utilisateur")
@CrossOrigin("*")
public class UtilisateurController {
	@Autowired
    private UtilisateurService utilisateurService;

    private static final String IMAGE_UPLOAD_DIR = "C:\\Users\\jorda\\Desktop\\Covoiturage-universitaire\\backend\\Covoiturage\\uploads\\";

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> save(
        @RequestPart(value = "nom", required = true) String nom,
        @RequestPart(value = "prenom", required = true) String prenom,
        @RequestPart(value = "email", required = true) String email,
        @RequestPart(value = "motDePasse", required = true) String motDePasse,
        @RequestPart(value = "telephone", required = true) String telephone,
        @RequestPart(value = "photoProfil", required = false) MultipartFile photoProfil) {

        // Vérification des champs requis
        if (nom == null || prenom == null || email == null || motDePasse == null || telephone == null) {
            return new ResponseEntity<>("Tous les champs sauf la photo de profil doivent être renseignés.", HttpStatus.BAD_REQUEST);
        }

        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom(nom);
        utilisateur.setPrenom(prenom);
        utilisateur.setEmail(email);
        utilisateur.setMotDePasse(motDePasse);
        utilisateur.setTelephone(telephone);

        if (photoProfil != null && !photoProfil.isEmpty()) {
            String photoPath = savePhoto(photoProfil);
            utilisateur.setPhotoProfil(photoPath);
        }

        Utilisateur res = utilisateurService.saveOrUpdate(utilisateur);
        if (res == null) {
            return new ResponseEntity<>("Échec d'enregistrement", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.ok(Map.of("url", res.getPhotoProfil()));
    }

    private String savePhoto(MultipartFile photoProfil) {
        try {
            File directory = new File(IMAGE_UPLOAD_DIR);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String fileName = System.currentTimeMillis() + "_" + photoProfil.getOriginalFilename();
            Path filePath = Paths.get(directory.getAbsolutePath(), fileName);
            Files.write(filePath, photoProfil.getBytes());

            return "http://votre-serveur.com/uploads/" + fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    @GetMapping
    public ResponseEntity<?> getAll() {
        return new ResponseEntity<>(utilisateurService.getAll(), HttpStatus.OK);
    }

    @GetMapping("/{utilisateurId}")
    public ResponseEntity<?> getById(@PathVariable("utilisateurId") String utilisateurId) {
        try {
            Utilisateur utilisateur = utilisateurService.getById(utilisateurId);
            return new ResponseEntity<>(utilisateur, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun utilisateur trouvé avec l'ID : " + utilisateurId, HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{utilisateurId}")
    public ResponseEntity<String> delete(@PathVariable("utilisateurId") String utilisateurId) {
        try {
            utilisateurService.delete(utilisateurId);
            return new ResponseEntity<>("Utilisateur supprimé avec succès", HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<>("Aucun utilisateur trouvé avec l'ID : " + utilisateurId, HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>("Échec de la suppression", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}