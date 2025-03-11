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
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
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
@Table(name = "avis")
@NamedQueries({
    @NamedQuery(name = "Avis.findAll", query = "SELECT a FROM Avis a"),
    @NamedQuery(name = "Avis.findByAvisId", query = "SELECT a FROM Avis a WHERE a.avisId = :avisId"),
    @NamedQuery(name = "Avis.findByUtilisateurId", query = "SELECT a FROM Avis a WHERE a.utilisateurId = :utilisateurId"),
    @NamedQuery(name = "Avis.findByNote", query = "SELECT a FROM Avis a WHERE a.note = :note"),
    @NamedQuery(name = "Avis.findByDateAvis", query = "SELECT a FROM Avis a WHERE a.dateAvis = :dateAvis")})
public class Avis implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "AVIS_ID")
    private Integer avisId;
    @Column(name = "UTILISATEUR_ID")
    private String utilisateurId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "NOTE")
    private Double note;
    @Lob
    @Column(name = "COMMENTAIRE")
    private String commentaire;
    @Column(name = "DATE_AVIS")
    @Temporal(TemporalType.DATE)
    private Date dateAvis;
    @JoinColumn(name = "UTILISATEUR_ID_ASSO_1", referencedColumnName = "UTILISATEUR_ID")
    @ManyToOne(optional = false)
    private Utilisateur utilisateurIdAsso1;

    public Avis() {
    }

    public Avis(Integer avisId) {
        this.avisId = avisId;
    }

    public Integer getAvisId() {
        return avisId;
    }

    public void setAvisId(Integer avisId) {
        this.avisId = avisId;
    }

    public String getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public Double getNote() {
        return note;
    }

    public void setNote(Double note) {
        this.note = note;
    }

    public String getCommentaire() {
        return commentaire;
    }

    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }

    public Date getDateAvis() {
        return dateAvis;
    }

    public void setDateAvis(Date dateAvis) {
        this.dateAvis = dateAvis;
    }

    public Utilisateur getUtilisateurIdAsso1() {
        return utilisateurIdAsso1;
    }

    public void setUtilisateurIdAsso1(Utilisateur utilisateurIdAsso1) {
        this.utilisateurIdAsso1 = utilisateurIdAsso1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (avisId != null ? avisId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Avis)) {
            return false;
        }
        Avis other = (Avis) object;
        if ((this.avisId == null && other.avisId != null) || (this.avisId != null && !this.avisId.equals(other.avisId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Avis[ avisId=" + avisId + " ]";
    }
    
}
