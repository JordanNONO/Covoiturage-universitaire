/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package covoiturage.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
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
@Table(name = "trajet")
@NamedQueries({
    @NamedQuery(name = "Trajet.findAll", query = "SELECT t FROM Trajet t"),
    @NamedQuery(name = "Trajet.findByTrajetId", query = "SELECT t FROM Trajet t WHERE t.trajetId = :trajetId"),
    @NamedQuery(name = "Trajet.findByUtilisateurId", query = "SELECT t FROM Trajet t WHERE t.utilisateurId = :utilisateurId"),
    @NamedQuery(name = "Trajet.findByVehiculeId", query = "SELECT t FROM Trajet t WHERE t.vehiculeId = :vehiculeId"),
    @NamedQuery(name = "Trajet.findByDepart", query = "SELECT t FROM Trajet t WHERE t.depart = :depart"),
    @NamedQuery(name = "Trajet.findByDestination", query = "SELECT t FROM Trajet t WHERE t.destination = :destination"),
    @NamedQuery(name = "Trajet.findByDateHeureDepart", query = "SELECT t FROM Trajet t WHERE t.dateHeureDepart = :dateHeureDepart"),
    @NamedQuery(name = "Trajet.findByTarif", query = "SELECT t FROM Trajet t WHERE t.tarif = :tarif"),
    @NamedQuery(name = "Trajet.findByPlacesDisponibles", query = "SELECT t FROM Trajet t WHERE t.placesDisponibles = :placesDisponibles")})
public class Trajet implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "TRAJET_ID")
    private String trajetId;
    @Column(name = "UTILISATEUR_ID")
    private String utilisateurId;
    @Column(name = "VEHICULE_ID")
    private String vehiculeId;
    @Column(name = "DEPART")
    private String depart;
    @Column(name = "DESTINATION")
    private String destination;
    @Column(name = "DATE_HEURE_DEPART")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateHeureDepart;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "TARIF")
    private Double tarif;
    @Column(name = "PLACES_DISPONIBLES")
    private Integer placesDisponibles;
    @JoinColumn(name = "UTILISATEUR_ID_ASSO_5", referencedColumnName = "UTILISATEUR_ID")
    @ManyToOne(optional = false)
    private Utilisateur utilisateurIdAsso5;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "trajetId")
    private Collection<Utilisateur> utilisateurCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "trajetId")
    private Collection<Vehicule> vehiculeCollection;

    public Trajet() {
    }

    public Trajet(String trajetId) {
        this.trajetId = trajetId;
    }

    public String getTrajetId() {
        return trajetId;
    }

    public void setTrajetId(String trajetId) {
        this.trajetId = trajetId;
    }

    public String getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public String getVehiculeId() {
        return vehiculeId;
    }

    public void setVehiculeId(String vehiculeId) {
        this.vehiculeId = vehiculeId;
    }

    public String getDepart() {
        return depart;
    }

    public void setDepart(String depart) {
        this.depart = depart;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Date getDateHeureDepart() {
        return dateHeureDepart;
    }

    public void setDateHeureDepart(Date dateHeureDepart) {
        this.dateHeureDepart = dateHeureDepart;
    }

    public Double getTarif() {
        return tarif;
    }

    public void setTarif(Double tarif) {
        this.tarif = tarif;
    }

    public Integer getPlacesDisponibles() {
        return placesDisponibles;
    }

    public void setPlacesDisponibles(Integer placesDisponibles) {
        this.placesDisponibles = placesDisponibles;
    }

    public Utilisateur getUtilisateurIdAsso5() {
        return utilisateurIdAsso5;
    }

    public void setUtilisateurIdAsso5(Utilisateur utilisateurIdAsso5) {
        this.utilisateurIdAsso5 = utilisateurIdAsso5;
    }

    public Collection<Utilisateur> getUtilisateurCollection() {
        return utilisateurCollection;
    }

    public void setUtilisateurCollection(Collection<Utilisateur> utilisateurCollection) {
        this.utilisateurCollection = utilisateurCollection;
    }

    public Collection<Vehicule> getVehiculeCollection() {
        return vehiculeCollection;
    }

    public void setVehiculeCollection(Collection<Vehicule> vehiculeCollection) {
        this.vehiculeCollection = vehiculeCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (trajetId != null ? trajetId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Trajet)) {
            return false;
        }
        Trajet other = (Trajet) object;
        if ((this.trajetId == null && other.trajetId != null) || (this.trajetId != null && !this.trajetId.equals(other.trajetId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Trajet[ trajetId=" + trajetId + " ]";
    }
    
}
