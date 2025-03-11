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
@Table(name = "reservation")
@NamedQueries({
    @NamedQuery(name = "Reservation.findAll", query = "SELECT r FROM Reservation r"),
    @NamedQuery(name = "Reservation.findByReservationId", query = "SELECT r FROM Reservation r WHERE r.reservationId = :reservationId"),
    @NamedQuery(name = "Reservation.findByUtilisateurId", query = "SELECT r FROM Reservation r WHERE r.utilisateurId = :utilisateurId"),
    @NamedQuery(name = "Reservation.findByTrajetId", query = "SELECT r FROM Reservation r WHERE r.trajetId = :trajetId"),
    @NamedQuery(name = "Reservation.findByStatut", query = "SELECT r FROM Reservation r WHERE r.statut = :statut"),
    @NamedQuery(name = "Reservation.findByDateReservation", query = "SELECT r FROM Reservation r WHERE r.dateReservation = :dateReservation"),
    @NamedQuery(name = "Reservation.findByModePaiement", query = "SELECT r FROM Reservation r WHERE r.modePaiement = :modePaiement")})
public class Reservation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "RESERVATION_ID")
    private String reservationId;
    @Column(name = "UTILISATEUR_ID")
    private String utilisateurId;
    @Column(name = "TRAJET_ID")
    private String trajetId;
    @Column(name = "STATUT")
    private String statut;
    @Column(name = "DATE_RESERVATION")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateReservation;
    @Column(name = "MODE_PAIEMENT")
    private String modePaiement;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "reservationId")
    private Collection<Paiement> paiementCollection;
    @JoinColumn(name = "UTILISATEUR_ID_ASSO_3", referencedColumnName = "UTILISATEUR_ID")
    @ManyToOne(optional = false)
    private Utilisateur utilisateurIdAsso3;

    public Reservation() {
    }

    public Reservation(String reservationId) {
        this.reservationId = reservationId;
    }

    public String getReservationId() {
        return reservationId;
    }

    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }

    public String getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public String getTrajetId() {
        return trajetId;
    }

    public void setTrajetId(String trajetId) {
        this.trajetId = trajetId;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Date getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(Date dateReservation) {
        this.dateReservation = dateReservation;
    }

    public String getModePaiement() {
        return modePaiement;
    }

    public void setModePaiement(String modePaiement) {
        this.modePaiement = modePaiement;
    }

    public Collection<Paiement> getPaiementCollection() {
        return paiementCollection;
    }

    public void setPaiementCollection(Collection<Paiement> paiementCollection) {
        this.paiementCollection = paiementCollection;
    }

    public Utilisateur getUtilisateurIdAsso3() {
        return utilisateurIdAsso3;
    }

    public void setUtilisateurIdAsso3(Utilisateur utilisateurIdAsso3) {
        this.utilisateurIdAsso3 = utilisateurIdAsso3;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (reservationId != null ? reservationId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Reservation)) {
            return false;
        }
        Reservation other = (Reservation) object;
        if ((this.reservationId == null && other.reservationId != null) || (this.reservationId != null && !this.reservationId.equals(other.reservationId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Reservation[ reservationId=" + reservationId + " ]";
    }
    
}
