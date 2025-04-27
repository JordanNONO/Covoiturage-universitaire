/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.covoiturage.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.UUID;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 *
 * @author jorda
 */
@Entity
@Table(name = "utilisateur")
@NamedQueries({
    @NamedQuery(name = "Utilisateur.findAll", query = "SELECT u FROM Utilisateur u"),
    @NamedQuery(name = "Utilisateur.findByUtilisateurId", query = "SELECT u FROM Utilisateur u WHERE u.utilisateurId = :utilisateurId"),
    @NamedQuery(name = "Utilisateur.findByNom", query = "SELECT u FROM Utilisateur u WHERE u.nom = :nom"),
    @NamedQuery(name = "Utilisateur.findByPrenom", query = "SELECT u FROM Utilisateur u WHERE u.prenom = :prenom"),
    @NamedQuery(name = "Utilisateur.findByEmail", query = "SELECT u FROM Utilisateur u WHERE u.email = :email"),
    @NamedQuery(name = "Utilisateur.findByMotDePasse", query = "SELECT u FROM Utilisateur u WHERE u.motDePasse = :motDePasse"),
    @NamedQuery(name = "Utilisateur.findByTelephone", query = "SELECT u FROM Utilisateur u WHERE u.telephone = :telephone"),
    @NamedQuery(name = "Utilisateur.findByDateInscription", query = "SELECT u FROM Utilisateur u WHERE u.dateInscription = :dateInscription"),
    @NamedQuery(name = "Utilisateur.findByNoteMoyenne", query = "SELECT u FROM Utilisateur u WHERE u.noteMoyenne = :noteMoyenne"),
    @NamedQuery(name = "Utilisateur.findByPhotoProfil", query = "SELECT u FROM Utilisateur u WHERE u.photoProfil = :photoProfil")})
public class Utilisateur implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Basic(optional = false)
    @Column(name = "UTILISATEUR_ID")
    private String utilisateurId;

    @Column(name = "NOM", nullable = false)
    private String nom;

    @Column(name = "PRENOM", nullable = false)
    private String prenom;

    @Column(name = "EMAIL", nullable = false)
    private String email;

    @Column(name = "MOT_DE_PASSE", nullable = false)
    private String motDePasse;

    @Column(name = "TELEPHONE", nullable = false)
    private String telephone;
    
    @Column(name = "DATE_INSCRIPTION")
    @Temporal(TemporalType.TIMESTAMP) // Utilisation de TIMESTAMP pour enregistrer la date et l'heure
    private Date dateInscription;

    @Column(name = "NOTE_MOYENNE")
    private Double noteMoyenne;  // Assurez-vous que cet attribut est présent

    @Column(name = "PHOTO_PROFIL")
    private String photoProfil; 
    
    @ManyToOne
    @JoinColumn(name = "TRAJET_ID", referencedColumnName = "TRAJET_ID", nullable = true)
    private Trajet trajetId;

    // Constructor
    public Utilisateur() {
        this.utilisateurId = UUID.randomUUID().toString(); // Génération d'un ID unique
        this.dateInscription = new Date(); // Initialisation de la date d'inscription à la date actuelle
    }

    // Getters et setters
    public String getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Date getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(Date dateInscription) {
        this.dateInscription = dateInscription;
    }
    public Double getNoteMoyenne() {
        return noteMoyenne;
    }

    public void setNoteMoyenne(Double noteMoyenne) {
        this.noteMoyenne = noteMoyenne;
    }

    public String getPhotoProfil() {
        return photoProfil;
    }

    public void setPhotoProfil(String photoProfil) {
        this.photoProfil = photoProfil;
    }

    @Override
    public int hashCode() {
        return (utilisateurId != null ? utilisateurId.hashCode() : 0);
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Utilisateur)) {
            return false;
        }
        Utilisateur other = (Utilisateur) object;
        return (this.utilisateurId != null || other.utilisateurId == null) &&
               (this.utilisateurId == null || this.utilisateurId.equals(other.utilisateurId));
    }

    @Override
    public String toString() {
        return "Utilisateur[ utilisateurId=" + utilisateurId + " ]";
    }
}
