package com.flightmanagement.addflight.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import com.flightmanagement.addflight.model.FlightDetails;
import com.flightmanagement.addflight.service.AddFlightService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AddFlightController {

	@Autowired
	private AddFlightService flightService;

	@Value("${gateway.base.url}")
	private String gatewayBaseUrl;

	

	@GetMapping("/addFlight")
	public String showForm(@RequestHeader(value = "X-Username", required = false) String username, HttpSession session,
			Model model) {

		if (username != null && !username.equals("Empty")) {
			session.setAttribute("loggedInUser", username);
			System.out.println("Username in AllFlightInfo: " + username);
		} else {
			System.out.println("No username found in header. Showing guest view.");
		}
		FlightDetails flightDetails = new FlightDetails(); // fresh instance
		model.addAttribute("flightObj", flightDetails);
		return "addFlight";
	}

	@PostMapping("/addFlight")
	public String submitForm(@ModelAttribute("flightObj") FlightDetails flight, HttpSession session) {
		String username = (String) session.getAttribute("loggedInUser");

		String message;
		if (username != null && !username.equals("Empty")) {

			if (flightService.getFlightID(flight.getId())) {
				flightService.saveFlight(flight);
				message = "Existing Flight details updated successfully.";
			} else {
				flightService.saveFlight(flight);
				message = "Flight details inserted successfully.";
			}

			return "redirect:" + gatewayBaseUrl + "/addFlight?message=" + message;
		} else {
			String errorMessage = "Access denied: only admin users can add flight details";
			return "redirect:" + gatewayBaseUrl + "/Userlogin?ticketerror=" + errorMessage;
		}
	}

}
