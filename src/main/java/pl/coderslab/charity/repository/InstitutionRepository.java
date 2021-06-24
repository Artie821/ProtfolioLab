package pl.coderslab.charity.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import pl.coderslab.charity.entity.Institution;

import java.util.List;

public interface InstitutionRepository extends JpaRepository<Institution, Long> {

    @Query("select i from Institution i WHERE i.enabled = true")
    List<Institution> findAllInstitutions();

    @Query("select i from Institution i")
    List<Institution> findAllInstitutionsAllStatuses();

    @Query("select i from Institution i WHERE i.id = ?1")
    Institution findByInstitutionId(Long id);

    @Transactional
    @Modifying
    @Query("update Institution i set i.name = ?2 where i.id = ?1")
    void UpdateInstitutionName(Long id, String name);

    @Transactional
    @Modifying
    @Query("update Institution i set i.description = ?2 where i.id = ?1")
    void UpdateInstitutionDescription(Long id, String description);

    @Transactional
    @Modifying
    @Query("update Institution i set i.enabled = ?2 where i.id = ?1")
    void UpdateInstitutionStatus(Long id, Boolean status);
}
