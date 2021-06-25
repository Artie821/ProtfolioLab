package pl.coderslab.charity.controllers;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import pl.coderslab.charity.email.EmailService;
import pl.coderslab.charity.entity.ConfirmationToken;

import pl.coderslab.charity.entity.UserEntity;
import pl.coderslab.charity.exeptions.EmailAlreadyExistExection;
import pl.coderslab.charity.exeptions.UserAlreadyExistException;
import pl.coderslab.charity.repository.ConfirmationTokenRepository;
import pl.coderslab.charity.repository.DonationRepository;
import pl.coderslab.charity.security.UserRepository;
import pl.coderslab.charity.security.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.time.LocalDate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Controller
@RequestMapping("")
public class UserController {

    private final EmailService emailService;
    private final UserService userService;
    private final BCryptPasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final DonationRepository donationRepository;
    private final ConfirmationTokenRepository confirmationTokenRepository;

    public UserController(EmailService emailService, UserService userService, BCryptPasswordEncoder passwordEncoder, UserRepository userRepository, DonationRepository donationRepository, ConfirmationTokenRepository confirmationTokenRepository) {
        this.emailService = emailService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.donationRepository = donationRepository;
        this.confirmationTokenRepository = confirmationTokenRepository;
    }


    @RequestMapping(value = {"/login"}, method = RequestMethod.GET)
    public String homepageLogin() {
        return "login";
    }

    @RequestMapping(value = {"/register"}, method = RequestMethod.GET)
    public String register(Model model) {
        model.addAttribute("userEntity", new UserEntity());
        return "register";
    }


    @GetMapping("/logged/userSettings")
    public String userSettings(@Valid UserEntity user, BindingResult result, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user1 = userService.findByUserName(username);
        model.addAttribute("userEntity", user1);
        return "logged/userSettings";
    }

    @PostMapping("/logged/userSettings")
    public String userDataChangeSave(@Valid UserEntity user, BindingResult result, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        UserEntity activeUser = userService.findByUserName(username);
        if (result.hasErrors()) {
            return "logged/userSettings";
        }
        UserEntity user1 = userService.findByUserName(username);
        if (passwordEncoder.matches(user.getPassword(), user1.getPassword())) {
            if ((userRepository.findByUsername(user.getUsername()) != null) && (userRepository.findByEmail(user.getEmail()) != null)) {
                model.addAttribute("user", activeUser);
                return "redirect:/logged/userSettings?userExist=true";
            } else {
                userRepository.UpdateUsername(user1.getId(), user.getUsername());
                userRepository.UpdateUserEmail(user1.getId(), user.getEmail());
                Authentication authentication = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        } else {
            model.addAttribute("user", activeUser);
            return "redirect:/logged/userSettings?wrongPassword=true";
        }
        return "redirect:/logged/userSettings?success=true";
    }

    @GetMapping("/logged/changePassword")
    public String userChangePassword(@Valid UserEntity user, BindingResult result, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        return "/logged/userChangePassword";
    }

    @PostMapping("/logged/changePassword")
    public String userSaveChangedPassword(@RequestParam String oldpass, @RequestParam String newpass, @RequestParam String newpassConfirm, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user1 = userService.findByUserName(username);
        if (passwordEncoder.matches(oldpass, user1.getPassword())) {
            if (newpass.equals(newpassConfirm)) {
                String regex = "^(?=.*[0-9])"
                        + "(?=.*[a-z])(?=.*[A-Z])"
                        + "(?=.*[@#$%^[.][,]&+=])"
                        + "(?=\\S+$).{8,20}$";
                Pattern pattern = Pattern.compile(regex);
                Matcher match = pattern.matcher(newpass);
                if (match.matches()) {
                    String password = passwordEncoder.encode(newpass);
                    userRepository.UpdatePassword(user1.getId(), password);
                    return "redirect:/logged/changePassword?success=true";
                } else {
                    return "redirect:/logged/changePassword?pattern=true";
                }
            } else {
                return "redirect:/logged/changePassword?notMatch=true";
            }
        }
        return "redirect:/logged/changePassword?invalidOld=true";
    }

    @GetMapping("/logged/donations")
    public String donations(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user = userRepository.findByUsername(username);
        model.addAttribute("donations", donationRepository.AllDonationsForUser(user));
        return "/logged/donations";
    }

    @GetMapping("/logged/donationsDetails/{id}")
    public String donationsDetails(@PathVariable long id, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user = userRepository.findByUsername(username);
        model.addAttribute("donation", donationRepository.findById(id).get());
        return "/logged/donationDetails";
    }

    @GetMapping("/logged/donationCancel/{id}")
    public String cancelDonation(@PathVariable long id, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user = userRepository.findByUsername(username);
        model.addAttribute("donation", donationRepository.findById(id).get());
        donationRepository.UpdateDonationStatus("ANULOWANA", id);
        return "redirect: ../../../donationsDetails/"+id;
    }

    @GetMapping("/logged/donationPassed/{id}")
    public String passedDonation(@PathVariable long id, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user = userRepository.findByUsername(username);
        LocalDate pickUpDate = LocalDate.now();
        donationRepository.UpdateDonationPickUpDate(pickUpDate, id);
        model.addAttribute("donation", donationRepository.findById(id).get());
        donationRepository.UpdateDonationStatus("ODEBRANE", id);
        return "redirect: ../../../donationsDetails/"+id;
    }

    @PostMapping("/emailSender")
    public String emailSender(@RequestParam String name, @RequestParam String surname,@RequestParam String message){
        try {
            emailService.sendSimpleMessage("kret335@gmail.com",name+" "+surname,message );
        } catch (Exception e){
            return "redirect:/?sendError=true#contact";
        }
        return "redirect:/?send=true#contact";
    }

    @PostMapping("/register")
    public String saveUserWithEmail(@Valid UserEntity user, BindingResult result, Model model, HttpServletRequest request) {

        String pathInfo = request.getRequestURL().toString().replace("/register","");
        if (result.hasErrors()) {
            return "register";
        }
        try {
            userService.saveUser(user);
            ConfirmationToken confirmationToken = new ConfirmationToken(user);
            confirmationTokenRepository.save(confirmationToken);
            emailService.sendSimpleMessage(user.getEmail(),"Rejestracja zakończona powodzeniem!","Aby aktywować konto, kliknij tutaj : " + pathInfo
                    +"/confirm-account?token="+confirmationToken.getConfirmationToken());

        } catch (UserAlreadyExistException e) {
            model.addAttribute("login", true);
            return "register";
        } catch (EmailAlreadyExistExection e) {
            model.addAttribute("email", true);
            return "register";
        }
        return "redirect:/registerSuccess?success=true";
    }



    @RequestMapping(value="/confirm-account", method= {RequestMethod.GET, RequestMethod.POST})
    public String confirmUserAccount( @RequestParam("token")String confirmationToken)
    {
        ConfirmationToken token = confirmationTokenRepository.findByConfirmationToken(confirmationToken);

        if(token != null)
        {
            UserEntity userEntity = userRepository.findByUsername(token.getUserEntity().getUsername());
            userEntity.setActive(true);
            userRepository.save(userEntity);
            return "redirect:/login?successToken=true";
        }
        else
        {
            return "badToken";
        }
    }

    @RequestMapping(value = {"/registerSuccess"}, method = RequestMethod.GET)
    public String registerSuccess(Model model) {
        return "RegisterSuccess";
    }

    @PostMapping("/logged/emailSender")
    public String loggedEmailSender(@RequestParam String name, @RequestParam String surname,@RequestParam String message){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();

        try {
            emailService.sendSimpleMessage("kret335@gmail.com",name+" "+surname + " " + username,message );
        } catch (Exception e){
            return "redirect:/logged/dashboard?sendError=true#contact";
        }
        return "redirect:/logged/dashboard?send=true#contact";
    }

    @GetMapping("/passwordReset")
    public String passwordReset() {
        return "/passwordReset";
    }

    @PostMapping("/passwordReset")
    public String passwordResetForm(@RequestParam String email, HttpServletRequest request){
        String pathInfo = request.getRequestURL().toString().replace("/passwordReset","");
        UserEntity user = userRepository.findByEmail(email);
        if(userRepository.findByEmail(email) == null){
          return "redirect: ../../passwordReset?missingEmail=true";
        }else {
            ConfirmationToken confirmationToken = new ConfirmationToken(userRepository.findByEmail(email));
            confirmationTokenRepository.save(confirmationToken);
            emailService.sendSimpleMessage(email,"Link do resetu hasła!","Aby utworzyć nowe hasło dla użytkownika " + user.getUsername() +" kliknij w link : "
                    +pathInfo+"/reset-password?token="+confirmationToken.getConfirmationToken());
            return "redirect: ../../passwordReset?success=true";
        }
    }

    @RequestMapping(value="/reset-password", method= {RequestMethod.GET})
    public String resetUserPassword( @RequestParam("token")String confirmationToken, Model model)
    {
        ConfirmationToken token = confirmationTokenRepository.findByConfirmationToken(confirmationToken);
        if(token != null)
        {
            UserEntity user = userRepository.findByUsername(token.getUserEntity().getUsername());
            model.addAttribute("user", user);
            model.addAttribute("token", confirmationToken );
            return "/setPassword";
        }
        else
        {
            return "badToken";
        }
    }

    @PostMapping("/savePassword")
    public String saveNewPassword(@RequestParam String password,@RequestParam String passconf, @RequestParam String email, @RequestParam String token, Model model){
        System.out.println(password + passconf + email);
        UserEntity user = userRepository.findByEmail(email);
        if (password.equals(passconf)) {
            String regex = "^(?=.*[0-9])"
                    + "(?=.*[a-z])(?=.*[A-Z])"
                    + "(?=.*[\\p{Punct}])"
                    + "(?=\\S+$).{8,20}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher match = pattern.matcher(password);
            if (match.matches()) {
                String passwordSave = passwordEncoder.encode(password);
                userRepository.UpdatePassword(user.getId(), passwordSave);
                return "redirect: ../../login?newPassword=true";
            } else {
                model.addAttribute("user", user);
                model.addAttribute("regex", true);
                return "/setPassword";
            }
        } else {
            model.addAttribute("user", user);
            model.addAttribute("match", true);
//            return "redirect: ../../reset-password?token="+token+"?regex=true";
            return "/setPassword";
        }


    }

}
