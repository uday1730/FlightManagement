package com.flightmanagement.sourceanddestination.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import com.flightmanagement.sourceanddestination.feignclient.FeignClientMethods;
import com.flightmanagement.sourceanddestination.service.SourceAndDestinationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SourceAndDestinationController {
	
	@Value("${gateway.base.url}")
	private String gatewayBaseUrl;
	
	@Autowired
	private FeignClientMethods feignClient;

	@Autowired
	private SourceAndDestinationService sdService;
	


	@GetMapping("/sourceAndDestination")
	public String searchFlights(@RequestHeader(value = "X-Username", required = false) String username,
	HttpSession session, Model model) {
		if (username != null && !username.equals("Empty")) {
		session.setAttribute("loggedInUser", username);
		System.out.println("Username in sd: " + username);
	} else {
		System.out.println("No username found in header. Showing guest view.");
	}
		
	//	System.out.println("in get");
		return "sourceanddestinaiton";
	}
	
	
	@PostMapping("sdticket")
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
