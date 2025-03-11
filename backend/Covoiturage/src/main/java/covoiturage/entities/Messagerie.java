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
@Table(name = "messagerie")
@NamedQueries({
    @NamedQuery(name = "Messagerie.findAll", query = "SELECT m FROM Messagerie m"),
    @NamedQuery(name = "Messagerie.findByMessageId", query = "SELECT m FROM Messagerie m WHERE m.messageId = :messageId"),
    @NamedQuery(name = "Messagerie.findByUtilisateurId", query = "SELECT m FROM Messagerie m WHERE m.utilisateurId = :utilisateurId"),
    @NamedQuery(name = "Messagerie.findByDateEnvoi", query = "SELECT m FROM Messagerie m WHERE m.dateEnvoi = :dateEnvoi")})
public class Messagerie implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "MESSAGE_ID")
    private Integer messageId;
    @Column(name = "UTILISATEUR_ID")
    private String utilisateurId;
    @Lob
    @Column(name = "CONTENU")
    private String contenu;
    @Column(name = "DATE_ENVOI")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateEnvoi;
    @JoinColumn(name = "UTILISATEUR_ID_ASSO_4", referencedColumnName = "UTILISATEUR_ID")
    @ManyToOne(optional = false)
    private Utilisateur utilisateurIdAsso4;

    public Messagerie() {
    }

    public Messagerie(Integer messageId) {
        this.messageId = messageId;
    }

    public Integer getMessageId() {
        return messageId;
    }

    public void setMessageId(Integer messageId) {
        this.messageId = messageId;
    }

    public String getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(String utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public Date getDateEnvoi() {
        return dateEnvoi;
    }

    public void setDateEnvoi(Date dateEnvoi) {
        this.dateEnvoi = dateEnvoi;
    }

    public Utilisateur getUtilisateurIdAsso4() {
        return utilisateurIdAsso4;
    }

    public void setUtilisateurIdAsso4(Utilisateur utilisateurIdAsso4) {
        this.utilisateurIdAsso4 = utilisateurIdAsso4;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (messageId != null ? messageId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Messagerie)) {
            return false;
        }
        Messagerie other = (Messagerie) object;
        if ((this.messageId == null && other.messageId != null) || (this.messageId != null && !this.messageId.equals(other.messageId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "covoiturage.entities.Messagerie[ messageId=" + messageId + " ]";
    }
    
}
