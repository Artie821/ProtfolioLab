package pl.coderslab.charity.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import pl.coderslab.charity.entity.Donation;
import pl.coderslab.charity.entity.UserEntity;

import java.time.LocalDate;
import java.util.List;


public interface DonationRepository extends JpaRepository<Donation, Long> {

    @Query("select SUM(d.quantity) FROM Donation d WHERE d.status<>'ANULOWANA'")
    Integer TotalBags();

    @Query("select count(d) FROM Donation d WHERE d.status<>'ANULOWANA'")
    Integer TotalDonations();

    @Query("select d FROM Donation d WHERE d.userEntity = ?1 ORDER BY d.status DESC, d.statusChangeDate, d.createdDate")
    List<Donation> AllDonationsForUser(UserEntity user);

    @Transactional
    @Modifying
    @Query("UPDATE Donation d SET d.status = ?1 WHERE d.id =?2")
    void UpdateDonationStatus(String status, Long id);

    @Transactional
    @Modifying
    @Query("UPDATE Donation d SET d.statusChangeDate = ?1 WHERE d.id =?2")
    void UpdateDonationPickUpDate(LocalDate date, Long id);

    @Transactional
    @Modifying
    @Query("UPDATE Donation d SET d.userEntity = ?1 WHERE d.id =?2")
    void UpdateDonationUser(UserEntity user, Long id);

}
