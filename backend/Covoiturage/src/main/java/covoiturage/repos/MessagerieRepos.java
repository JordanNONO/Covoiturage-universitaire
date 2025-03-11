package covoiturage.repos;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import covoiturage.entities.Messagerie;

@Repository
public interface MessagerieRepos extends JpaRepository<Messagerie, Short> {

}
