package com.flightmanagement.userplan.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.flightmanagement.userplan.model.FlightDetails;
import com.flightmanagement.userplan.service.UserPlanService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserPlanController {

	@Autowired
	private UserPlanService userPlanService;
	
	
	@Value("${gateway.base.url}")
	private String gatewayBaseUrl;

	@RequestMapping(value = "/plan", method = { RequestMethod.GET, RequestMethod.POST })
	public String handlePlan(@RequestHeader(value = "X-Username", required = false) String username,@RequestParam(required = false) String source,
			@RequestParam(required = false) String destination, @RequestParam(required = false) Integer fare,
			Model model, HttpSession session) {

		
		if (username != null && !username.equals("Empty")) {
			session.setAttribute("loggedInUser", username);
			System.out.println("Username in plan: " + username);
		} else {
			System.out.println("No username found in header. Showing guest view.");
		}

		// If form was submitted, process the search
		if (source != null && destination != null && fare != null) {
			List<FlightDetails> planflights = userPlanService.getSourceDestinationFare(source, destination, fare);
			model.addAttribute("planflights", planflights);
			model.addAttribute("submitted", true);
			model.addAttribute("source", source);
			model.addAttribute("destination", destination);
			model.addAttribute("fare", fare);
		}

		return "plan";
	}

	@GetMapping("/api/sources")
	@ResponseBody
	public List<String> getMatchingSources(@RequestParam String query) {
		System.out.println("IN");
		System.out.println(userPlanService.findSourcesContaining(query));
		return userPlanService.findSourcesContaining(query);
	}

	@GetMapping("/api/destinations")
	@ResponseBody
	public List<String> getMatchingDestinations(@RequestParam String query) {
		return userPlanService.findDestinationsContaining(query);
	}
	
	@PostMapping("plticket")
	public String printTicket(HttpSession session, @RequestParam Integer id, Model model) {
		String username = (String) session.getAttribute("loggedInUser");

		if (username != null && !username.equals("Empty")) {
			System.out.println("Booking flight ID: " + id + " for user: " + username);
			model.addAttribute("flightId", id);
			model.addAttribute("username", username);
			return "ticket";
		} else {
			String errorMessage = "To book, user login is compulsory";
			return "redirect:" + gatewayBaseUrl + "/Userlogin?ticketerror=" + errorMessage;

		}
	}

}
