package pl.coderslab.charity.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import pl.coderslab.charity.entity.ConfirmationToken;
import pl.coderslab.charity.entity.UserEntity;

import java.util.List;

public interface ConfirmationTokenRepository extends CrudRepository<ConfirmationToken, String> {
    ConfirmationToken findByConfirmationToken(String confirmationToken);

    @Query
    List<ConfirmationToken> findAllByUserEntity(UserEntity userEntity);
}
