/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package covoiturage.entities;

import java.io.Serializable;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

/**
 *
 * @author jorda
 */
@Entity
@Table(name = "vehicule")
@NamedQueries({
    @NamedQuery(name = "Vehicule.findAll", query = "SELECT v FROM Vehicule v"),
    @NamedQuery(name = "Vehicule.findByVehiculeId", query = "SELECT v FROM Vehicule v WHERE v.vehiculeId = :vehiculeId"),
    @NamedQuery(name = "Vehicule.findByUtilisateurId", query = "SELECT v FROM Vehicule v WHERE v.utilisateurId = :utilisateurId"),
    @NamedQuery(name = "Vehicule.findByMarque", query = "SELECT v FROM Vehicule v WHERE v.marque = :marque"),
    @NamedQuery(name = "Vehicule.findByModele", query = "SELECT v FROM Vehicule v WHERE v.modele = :modele"),
    @NamedQuery(name = "Vehicule.findByAnnee", query = "SELECT v FROM Vehicule v WHERE v.annee = :annee"),
    @NamedQuery(name = "Vehicule.findByImmatriculation", query = "SELECT v FROM Vehicule v WHERE v.immatriculation = :immatriculation"),
    @NamedQuery(name = "Vehicule.findByPlacesDisponibles", query = "SELECT v FROM Vehicule v WHERE v.placesDisponibles = :placesDisponibles"),
    @NamedQuery(name = "Vehicule.findByCouleur", query = "SELECT v FROM Vehicule v WHERE v.couleur = :couleur")})
public class Vehicule implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "VEHICULE_ID")
    private String vehiculeId;
    @Column(name = "UTILISATEUR_ID")
    private String utilisateurId;
    @Column(name = "MARQUE")
    private String marque;
    @Column(name = "MODELE")
    private String modele;
    @Column(name = "ANNEE")
    private Integer annee;
    @Column(name = "IMMATRICULATION")
    private String immatriculation;
    @Column(name = "PLACES_DISPONIBLES")
    private Integer placesDisponibles;
    @Column(name = "COULEUR")
    private String couleur;
    @JoinColumn(name = "TRAJET_ID", referencedColumnName = "TRAJET_ID")
    @ManyToOne(optional = false)
    private Trajet trajetId;
    @JoinColumn(name = "UTILISATEUR_ID_ASSO_6", referencedColumnName = "UTILISATEUR_ID")
    @ManyToOne
    private Utilisateur utilisateurIdAsso6;

    public Vehicule() {
    }

    public Vehicule(String vehiculeId) {
        this.vehiculeId = vehiculeId;
    }

    public String getVehiculeId() {
        return vehiculeId;
    }

    public void setVehiculeId(String vehiculeId) {
        this.vehiculeId = vehiculeId;
    }

    public String getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Integer getAnnee() {
        return annee;
    }

    public void setAnnee(Integer annee) {
        this.annee = annee;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public Integer getPlacesDisponibles() {
        return placesDisponibles;
    }

    public void setPlacesDisponibles(Integer placesDisponibles) {
        this.placesDisponibles = placesDisponibles;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }

    public Trajet getTrajetId() {
        return trajetId;
    }

    public void setTrajetId(Trajet trajetId) {
        this.trajetId = trajetId;
    }

    public Utilisateur getUtilisateurIdAsso6() {
        return utilisateurIdAsso6;
    }

    public void setUtilisateurIdAsso6(Utilisateur utilisateurIdAsso6) {
        this.utilisateurIdAsso6 = utilisateurIdAsso6;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (vehiculeId != null ? vehiculeId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Vehicule)) {
            return false;
        }
        Vehicule other = (Vehicule) object;
        if ((this.vehiculeId == null && other.vehiculeId != null) || (this.vehiculeId != null && !this.vehiculeId.equals(other.vehiculeId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Vehicule[ vehiculeId=" + vehiculeId + " ]";
    }
    
}
