package pl.coderslab.charity.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.coderslab.charity.entity.Institution;
import pl.coderslab.charity.repository.DonationRepository;
import pl.coderslab.charity.repository.InstitutionRepository;

import java.util.List;

@Controller
@RequestMapping("")
public class HomeController {

    private final InstitutionRepository institutionRepository;
    private final DonationRepository donationRepository;

    public HomeController(InstitutionRepository institutionRepository, DonationRepository donationRepository) {
        this.institutionRepository = institutionRepository;
        this.donationRepository = donationRepository;
    }

    @GetMapping("/")
    public String home(Model model) {
        List<Institution> institutions = institutionRepository.findAllInstitutions();
        model.addAttribute("institutions", institutions);
        model.addAttribute("totalBags", donationRepository.TotalBags());
        model.addAttribute("totalDonations", donationRepository.TotalDonations());
        return "index";
    }

    @GetMapping("/start")
    public String start(Model model) {
        List<Institution> institutions = institutionRepository.findAllInstitutions();
        model.addAttribute("institutions", institutions);
        model.addAttribute("totalBags", donationRepository.TotalBags());
        model.addAttribute("totalDonations", donationRepository.TotalDonations());
        return "start";
    }
}
