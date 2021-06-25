package pl.coderslab.charity.controllers;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.charity.entity.Category;
import pl.coderslab.charity.entity.Donation;
import pl.coderslab.charity.entity.Institution;
import pl.coderslab.charity.repository.CategoryRepository;
import pl.coderslab.charity.repository.DonationRepository;
import pl.coderslab.charity.repository.InstitutionRepository;
import pl.coderslab.charity.security.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;



@Controller
@RequestMapping("/logged/")
@ComponentScan
public class DonationController {

    private final UserService userService;
    private final InstitutionRepository institutionRepository;
    private final DonationRepository donationRepository;
    private final CategoryRepository categoryRepository;

    public DonationController(UserService userService, InstitutionRepository institutionRepository, DonationRepository donationRepository, CategoryRepository categoryRepository) {
        this.userService = userService;
        this.institutionRepository = institutionRepository;
        this.donationRepository = donationRepository;
        this.categoryRepository = categoryRepository;
    }

    @GetMapping("/form")
    public String form(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);

        model.addAttribute("donation", new Donation());
        model.addAttribute("categories", categoryRepository.findAll());
        model.addAttribute("institutions", institutionRepository.findAllInstitutions());

        return "logged/form";
    }


    @RequestMapping(value = {"confirm"}, method = RequestMethod.POST)
    public String formConfirmation(@Valid Donation donation, BindingResult result, @RequestParam List<String> category,@RequestParam String instit,@RequestParam String pickUpDate, Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);

        List<Category> categories = new ArrayList<>();
        for (String c: category) {
            categories.add(categoryRepository.findAllByCategoryName(c));
        }
        Long instID = Long.parseLong(instit);
        donation.setUserEntity(userService.findByUserName(username));
        donation.setInstitution(institutionRepository.findByInstitutionId(instID));
        donation.setCategories(categories);
        donation.setStatus("NIEODEBRANE");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate inputAdDate = LocalDate.parse(pickUpDate, formatter);
        donation.setPickUpDate(inputAdDate);
        donation.setCreatedDate(LocalDate.now());
        donationRepository.save(donation);
        return "logged/form_confirmation";
    }



    @RequestMapping(value = {"/dashboard"}, method = RequestMethod.GET)
    public String dashboard(Model model, HttpServletRequest request) {
        if (request.isUserInRole("ROLE_ADMIN")) {
            return "redirect:/admin/";
        }

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = ((UserDetails) principal).getUsername();
        model.addAttribute("username", username);

        List<Institution> institutions = institutionRepository.findAllInstitutions();
        model.addAttribute("institutions", institutions);
        Integer donationsNumber;
        if(donationRepository.TotalBags()==null){
            donationsNumber = 0;
        } else {
            donationsNumber = donationRepository.TotalBags();
        }
        model.addAttribute("totalBags", donationsNumber);
        model.addAttribute("totalDonations", donationRepository.TotalDonations());
        return "logged/dashboard";
    }

}
