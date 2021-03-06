package pl.coderslab.charity.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import pl.coderslab.charity.entity.UserEntity;

import java.util.HashSet;
import java.util.Set;

public class SpringDataUserDetailsService implements UserDetailsService {

    private UserService userService;

    @Autowired
    public void setUserRepository(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) {
        UserEntity user = userService.findByUserName(username);
        if (user != null && user.isActive()) {
            Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
            user.getRoles().forEach(r ->
                    grantedAuthorities.add(new SimpleGrantedAuthority(r.getName())));
            return new org.springframework.security.core.userdetails.User(
                    user.getUsername(), user.getPassword(), grantedAuthorities);
        } else {
            throw new UsernameNotFoundException(username);
        }
    }
}
