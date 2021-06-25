package pl.coderslab.charity.security;



import pl.coderslab.charity.entity.UserEntity;
import pl.coderslab.charity.exeptions.EmailAlreadyExistExection;
import pl.coderslab.charity.exeptions.UserAlreadyExistException;

public interface UserService {

    UserEntity findByUserName(String name);

    void saveUser(UserEntity user) throws UserAlreadyExistException, EmailAlreadyExistExection;


    boolean checkIfUserExist(String email);

    boolean checkIfUserExistLogin(String login);

    void saveAdmin(UserEntity user) throws UserAlreadyExistException, EmailAlreadyExistExection;

}