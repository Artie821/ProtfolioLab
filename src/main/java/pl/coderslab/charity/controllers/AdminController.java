package pl.coderslab.charity.controllers;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import pl.coderslab.charity.entity.ConfirmationToken;
import pl.coderslab.charity.entity.Donation;
import pl.coderslab.charity.entity.Institution;
import pl.coderslab.charity.entity.UserEntity;
import pl.coderslab.charity.exeptions.EmailAlreadyExistExection;
import pl.coderslab.charity.exeptions.UserAlreadyExistException;
import pl.coderslab.charity.repository.ConfirmationTokenRepository;
import pl.coderslab.charity.repository.DonationRepository;
import pl.coderslab.charity.repository.InstitutionRepository;
import pl.coderslab.charity.security.RoleRepository;
import pl.coderslab.charity.security.UserRepository;
import pl.coderslab.charity.security.UserService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/")
@ComponentScan
public class AdminController {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final InstitutionRepository institutionRepository;
    private final UserService userService;
    private final DonationRepository donationRepository;
    private final ConfirmationTokenRepository confirmationTokenRepository;

    public AdminController(UserRepository userRepository, RoleRepository roleRepository, InstitutionRepository institutionRepository, UserService userService, DonationRepository donationRepository, ConfirmationTokenRepository confirmationTokenRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.institutionRepository = institutionRepository;
        this.userService = userService;
        this.donationRepository = donationRepository;
        this.confirmationTokenRepository = confirmationTokenRepository;
    }

    @GetMapping("/")
    public String form(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        List<UserEntity> userList = userRepository.findAll();
        List<UserEntity> usersRoleUser = new ArrayList<>();
        String string = roleRepository.findRoleById(1L).toString();

        for (UserEntity u : userList) {
            String role = u.getRoles().toString();
            if (role.substring(1, role.length() - 1).equals(string)) {
                usersRoleUser.add(u);
            }
        }
        model.addAttribute("users", usersRoleUser);
        return "admin/admin";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable long id) {
        UserEntity user1 = userRepository.findById(id).get();
       List<Donation> donations = donationRepository.AllDonationsForUser(user1);
       List<ConfirmationToken> tokens = confirmationTokenRepository.findAllByUserEntity(user1);
       for (ConfirmationToken c: tokens){
           confirmationTokenRepository.delete(c);
       }
        for (Donation d: donations){
          donationRepository.delete(d);
        }
        userRepository.delete(user1);
        return "redirect:../";
    }

    @GetMapping("/status/{id}")
    public String statusChange(@PathVariable long id) {
        UserEntity user = userRepository.findById(id).get();
        if (user.isActive()) {
            userRepository.UpdateStatus(user.getId(), false);
        } else {
            userRepository.UpdateStatus(user.getId(), true);
        }
        return "redirect:../";
    }

    @GetMapping("/edit/{id}")
    public String editUser(@PathVariable long id, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user1 = userRepository.findById(id).get();
        model.addAttribute("user", user1);
        return "admin/editUser";
    }

    @PostMapping("/edit/")
    public String saveUser(Model model, UserEntity user) {

        if ((userRepository.findByUsername(user.getUsername()) != null) && (userRepository.findByEmail(user.getEmail()) != null)) {
            return "redirect:../edit/"+user.getId()+"?exist=true";
        } else {
            userRepository.UpdateUsername(user.getId(), user.getUsername());
            userRepository.UpdateUserEmail(user.getId(), user.getEmail());
        }
        return "redirect:../?success=true";
    }

    @GetMapping("/admins")
    public String editAdmins(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        List<UserEntity> userList = userRepository.findAll();
        List<UserEntity> adminsRoleUser = new ArrayList<>();
        String string = roleRepository.findRoleById(2L).toString();

        for (UserEntity u : userList) {
            String role = u.getRoles().toString();
            if (role.substring(1, role.length() - 1).equals(string)) {
                adminsRoleUser.add(u);
            }
        }
        model.addAttribute("admins", adminsRoleUser);
        return "admin/admins";
    }

    @GetMapping("/Aedit/{id}")
    public String editAdmin(@PathVariable long id, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        UserEntity user1 = userRepository.findById(id).get();
        model.addAttribute("admin", user1);
        return "admin/adminEdit";
    }

    @PostMapping("/Aedit/")
    public String saveAdmin(Model model, UserEntity user) {

        if ((userRepository.findByUsername(user.getUsername()) != null) && (userRepository.findByEmail(user.getEmail()) != null)) {
            return "redirect:../Aedit/"+user.getId()+"?exist=true";
        } else {
            userRepository.UpdateUsername(user.getId(), user.getUsername());
            userRepository.UpdateUserEmail(user.getId(), user.getEmail());
        }
        return "redirect:../admins?success=true";
    }

    @GetMapping("/Astatus/{id}")
    public String statusChangeAdmin(@PathVariable long id) {
        UserEntity user = userRepository.findById(id).get();
        if (user.isActive()) {
            userRepository.UpdateStatus(user.getId(), false);
        } else {
            userRepository.UpdateStatus(user.getId(), true);
        }
        return "redirect:../admins";
    }

    @RequestMapping(value = {"/registerA"}, method = RequestMethod.GET)
    public String registerAdmin(Model model) {
        model.addAttribute("userEntity", new UserEntity());
        return "admin/addAdmin";
    }

    @PostMapping("/registerA")
    public String saveAdmin(@Valid UserEntity user, BindingResult result, Model model) {
        if (result.hasErrors()) {

            return "redirect:/admin/registerA?exist=true";
        }
        try {
            userService.saveAdmin(user);
        } catch (UserAlreadyExistException e) {
            model.addAttribute("login", true);
            return "redirect:/admin/registerA?login=true";
        } catch (EmailAlreadyExistExection e) {
            model.addAttribute("email", true);
            return "redirect:/admin/registerA?email=true";
        }
        return "redirect:/admin/admins?success=true";
    }

    @GetMapping("/deleteA/{id}")
    public String deleteAdmin(@PathVariable long id) {
        UserEntity user1 = userRepository.findById(id).get();
        List<Donation> donations = donationRepository.AllDonationsForUser(user1);
        List<ConfirmationToken> tokens = confirmationTokenRepository.findAllByUserEntity(user1);
        for (ConfirmationToken c: tokens){
            confirmationTokenRepository.delete(c);
        }
        for (Donation d: donations){
            donationRepository.delete(d);
        }
        userRepository.delete(user1);
        return "redirect:../admins";
    }

    @GetMapping("/foundations")
    public String editFoundations(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        model.addAttribute("institution", institutionRepository.findAllInstitutionsAllStatuses());
        return "admin/foundations";
    }

    @GetMapping("/Fedit/{id}")
    public String editFoundation(@PathVariable long id, Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);
        Institution institution = institutionRepository.findByInstitutionId(id);
        model.addAttribute("fundation", institution);
        return "admin/foundationEdit";
    }

    @PostMapping("/Fedit/")
    public String saveFoundation(Model model, Institution institution) {
        institutionRepository.UpdateInstitutionName(institution.getId(),institution.getName());
        institutionRepository.UpdateInstitutionDescription(institution.getId(),institution.getDescription());
        return "redirect:../foundations?success=true";
    }

    @GetMapping("/deleteF/{id}")
    public String deleteFoundation(@PathVariable long id) {
       Institution institution = institutionRepository.findByInstitutionId(id);
        if(institution.getEnabled()){
       institutionRepository.UpdateInstitutionStatus(id,false);}
        if(!institution.getEnabled()){
            institutionRepository.UpdateInstitutionStatus(id,true);}
        return "redirect:../foundations";
    }

    @RequestMapping(value = {"/registerF"}, method = RequestMethod.GET)
    public String registerFoundation(Model model) {
        model.addAttribute("institution", new Institution());
        return "admin/addFundation";
    }

    @PostMapping("/registerF")
    public String saveFoundation(@Valid Institution institution, BindingResult result) {
        if (result.hasErrors()) {
            return "admin/addFundation";
        }
        try {
            institution.setEnabled(true);
            institutionRepository.save(institution);
        } catch (Exception e) {
            return "admin/addFundation";
        }
        return "redirect:/admin/foundations?success=true";
    }

}
