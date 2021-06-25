package pl.coderslab.charity.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import pl.coderslab.charity.entity.UserEntity;
import pl.coderslab.charity.exeptions.EmailAlreadyExistExection;
import pl.coderslab.charity.exeptions.UserAlreadyExistException;

import java.util.ArrayList;
import java.util.Arrays;


@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository,
                           BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public UserEntity findByUserName(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public void saveUser(UserEntity user) throws UserAlreadyExistException, EmailAlreadyExistExection {
        if (checkIfUserExist(user.getEmail())) {
            throw new EmailAlreadyExistExection("User already exists for this email");
        }
        if (checkIfUserExistLogin(user.getUsername())) {
            throw new UserAlreadyExistException("User already exists for this login");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        Role userRole = roleRepository.findByName("ROLE_USER");
        user.setRoles(new ArrayList<>(Arrays.asList(userRole)));
        user.setActive(false);
        userRepository.save(user);
    }

    @Override
    public void saveAdmin(UserEntity user) throws UserAlreadyExistException, EmailAlreadyExistExection {
        if (checkIfUserExist(user.getEmail())) {
            throw new EmailAlreadyExistExection("User already exists for this email");
        }
        if (checkIfUserExistLogin(user.getUsername())) {
            throw new UserAlreadyExistException("User already exists for this login");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        Role userRole = roleRepository.findByName("ROLE_ADMIN");
        user.setRoles(new ArrayList<>(Arrays.asList(userRole)));
        user.setActive(true);
        userRepository.save(user);
    }

    @Override
    public boolean checkIfUserExist(String email) {
        return userRepository.findByEmail(email) != null ? true : false;
    }

    @Override
    public boolean checkIfUserExistLogin(String login) {
        return userRepository.findByUsername(login) != null ? true : false;
    }


}
