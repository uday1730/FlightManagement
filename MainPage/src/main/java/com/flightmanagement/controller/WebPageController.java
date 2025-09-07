package com.flightmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flightmanagement.feignclient.UserServiceClient;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("homePage")
public class WebPageController { 


	
	@Autowired
	private UserServiceClient userServiceClient;
	
	
	
	@GetMapping("")
	public String mainPage(@RequestHeader(value = "X-Username", required = false) String username,
	                       HttpSession session,
	                       Model model) {
	    if (username != null && !username.equals("Empty")) {
	        session.setAttribute("loggedInUser", username);
	    //    model.addAttribute("loggedInUser", username);
	        
	        

	        // Check admin status via Feign
	        Boolean isAdmin = userServiceClient.isAdmin(username);
	        model.addAttribute("isAdmin", isAdmin);

	        System.out.println("Logged-in user: " + username + " | Admin: " + isAdmin);
	    } else {
	        model.addAttribute("isAdmin", false); // default to non-admin
	        System.out.println("No username found in header. Showing default main page.");
	    }

	    return "mainpage";
	}
//	
//	@GetMapping("/username")
//	@ResponseBody // Important: tells Spring to return raw text, not a view
//	public String getUsername(HttpSession session) {
//	    String username = (String) session.getAttribute("loggedInUser");
//	    System.out.println("Returning username to UserBookingService: " + username);
//	    return username != null ? username : "Empty";
//	}






	
}
