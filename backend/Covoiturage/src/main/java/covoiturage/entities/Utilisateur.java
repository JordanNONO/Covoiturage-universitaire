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
    @Column(name = "NOM")
    private String nom;
    @Column(name = "PRENOM")
    private String prenom;
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "MOT_DE_PASSE")
    private String motDePasse;
    @Column(name = "TELEPHONE")
    private String telephone;
    @Column(name = "DATE_INSCRIPTION")
    @Temporal(TemporalType.DATE)
    private Date dateInscription;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "NOTE_MOYENNE")
    private Double noteMoyenne;
    @Column(name = "PHOTO_PROFIL")
    private String photoProfil;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "utilisateurIdAsso5")
    private Collection<Trajet> trajetCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "utilisateurIdAsso1")
    private Collection<Avis> avisCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "utilisateurId")
    private Collection<Role> roleCollection;
    @JoinColumn(name = "TRAJET_ID", referencedColumnName = "TRAJET_ID")
    @ManyToOne(optional = false)
    private Trajet trajetId;
    @OneToMany(mappedBy = "utilisateurIdAsso6")
    private Collection<Vehicule> vehiculeCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "utilisateurIdAsso3")
    private Collection<Reservation> reservationCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "utilisateurIdAsso4")
    private Collection<Messagerie> messagerieCollection;

    public Utilisateur() {
    }

    public Utilisateur(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

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

    public Collection<Trajet> getTrajetCollection() {
        return trajetCollection;
    }

    public void setTrajetCollection(Collection<Trajet> trajetCollection) {
        this.trajetCollection = trajetCollection;
    }

    public Collection<Avis> getAvisCollection() {
        return avisCollection;
    }

    public void setAvisCollection(Collection<Avis> avisCollection) {
        this.avisCollection = avisCollection;
    }

    public Collection<Role> getRoleCollection() {
        return roleCollection;
    }

    public void setRoleCollection(Collection<Role> roleCollection) {
        this.roleCollection = roleCollection;
    }

    public Trajet getTrajetId() {
        return trajetId;
    }

    public void setTrajetId(Trajet trajetId) {
        this.trajetId = trajetId;
    }

    public Collection<Vehicule> getVehiculeCollection() {
        return vehiculeCollection;
    }

    public void setVehiculeCollection(Collection<Vehicule> vehiculeCollection) {
        this.vehiculeCollection = vehiculeCollection;
    }

    public Collection<Reservation> getReservationCollection() {
        return reservationCollection;
    }

    public void setReservationCollection(Collection<Reservation> reservationCollection) {
        this.reservationCollection = reservationCollection;
    }

    public Collection<Messagerie> getMessagerieCollection() {
        return messagerieCollection;
    }

    public void setMessagerieCollection(Collection<Messagerie> messagerieCollection) {
        this.messagerieCollection = messagerieCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (utilisateurId != null ? utilisateurId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Utilisateur)) {
            return false;
        }
        Utilisateur other = (Utilisateur) object;
        if ((this.utilisateurId == null && other.utilisateurId != null) || (this.utilisateurId != null && !this.utilisateurId.equals(other.utilisateurId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Utilisateur[ utilisateurId=" + utilisateurId + " ]";
    }
    
}
