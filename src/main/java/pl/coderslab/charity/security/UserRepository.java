package pl.coderslab.charity.security;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.coderslab.charity.entity.UserEntity;



@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    UserEntity findByUsername(String username);

    UserEntity findByEmail(String email);

    @Transactional
    @Modifying
    @Query("update UserEntity u set u.username = ?2 where u.id = ?1")
    void UpdateUsername(Long id, String user);

    @Transactional
    @Modifying
    @Query("update UserEntity u set u.email = ?2 where u.id = ?1")
    void UpdateUserEmail(Long id, String email);

    @Transactional
    @Modifying
    @Query("update UserEntity u set u.active = ?2 where u.id = ?1")
    void UpdateStatus(Long id, Boolean status);

    @Transactional
    @Modifying
    @Query("update UserEntity u set u.password = ?2 where u.id = ?1")
    void UpdatePassword(Long id, String password);
}
