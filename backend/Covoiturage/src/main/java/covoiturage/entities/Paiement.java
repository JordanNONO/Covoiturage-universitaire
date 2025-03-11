/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package covoiturage.entities;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 *
 * @author jorda
 */
@Entity
@Table(name = "paiement")
@NamedQueries({
    @NamedQuery(name = "Paiement.findAll", query = "SELECT p FROM Paiement p"),
    @NamedQuery(name = "Paiement.findByPaiementId", query = "SELECT p FROM Paiement p WHERE p.paiementId = :paiementId"),
    @NamedQuery(name = "Paiement.findByMontant", query = "SELECT p FROM Paiement p WHERE p.montant = :montant"),
    @NamedQuery(name = "Paiement.findByMethode", query = "SELECT p FROM Paiement p WHERE p.methode = :methode"),
    @NamedQuery(name = "Paiement.findByStatut", query = "SELECT p FROM Paiement p WHERE p.statut = :statut"),
    @NamedQuery(name = "Paiement.findByDatePaiement", query = "SELECT p FROM Paiement p WHERE p.datePaiement = :datePaiement")})
public class Paiement implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "PAIEMENT_ID")
    private String paiementId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "MONTANT")
    private Double montant;
    @Column(name = "METHODE")
    private String methode;
    @Column(name = "STATUT")
    private String statut;
    @Column(name = "DATE_PAIEMENT")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datePaiement;
    @JoinColumn(name = "RESERVATION_ID", referencedColumnName = "RESERVATION_ID")
    @ManyToOne(optional = false)
    private Reservation reservationId;

    public Paiement() {
    }

    public Paiement(String paiementId) {
        this.paiementId = paiementId;
    }

    public String getPaiementId() {
        return paiementId;
    }

    public void setPaiementId(String paiementId) {
        this.paiementId = paiementId;
    }

    public Double getMontant() {
        return montant;
    }

    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public String getMethode() {
        return methode;
    }

    public void setMethode(String methode) {
        this.methode = methode;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Date getDatePaiement() {
        return datePaiement;
    }

    public void setDatePaiement(Date datePaiement) {
        this.datePaiement = datePaiement;
    }

    public Reservation getReservationId() {
        return reservationId;
    }

    public void setReservationId(Reservation reservationId) {
        this.reservationId = reservationId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (paiementId != null ? paiementId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Paiement)) {
            return false;
        }
        Paiement other = (Paiement) object;
        if ((this.paiementId == null && other.paiementId != null) || (this.paiementId != null && !this.paiementId.equals(other.paiementId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Paiement[ paiementId=" + paiementId + " ]";
    }
    
}
