package com.flightmanagement.allflightinfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import com.flightmanagement.allflightinfo.model.BookingRecord;
import com.flightmanagement.allflightinfo.model.FlightDetails;
import com.flightmanagement.allflightinfo.service.AllFlightInfoService;
import com.flightmanagement.allflightinfo.service.BookingRecordService;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.http.HttpSession;

@Controller
public class AllFlightInfoController {

	@Value("${gateway.base.url}")
	private String gatewayBaseUrl;
	
	@Autowired
	private AllFlightInfoService allFlightservice;
	@Autowired
	private BookingRecordService bookingRecordservice;

	@GetMapping("/allFlightInfo")
	public String allFlightInfo(@RequestHeader(value = "X-Username", required = false) String username,
			HttpSession session) {
		if (username != null && !username.equals("Empty")) {
			session.setAttribute("loggedInUser", username);
			System.out.println("Username in AllFlightInfo: " + username);
		} else {
			System.out.println("No username found in header. Showing guest view.");
		}
		return "allflightinfo";
	}

//	@PostMapping("ticket")
//	public String printTicket(HttpSession session, @RequestParam Integer id, Model model) {
//
//		String username = (String) session.getAttribute("loggedInUser");
//
//		if (username != null && !username.equals("Empty")) {
//			System.out.println("Booking flight ID: " + id + " for user: " + username);
//			model.addAttribute("flightId", id);
//			model.addAttribute("username", username);
//			return "ticket";
//		} else {
//			String errorMessage = "To book, user login is compulsory";
//			return "redirect:" + gatewayBaseUrl + "/Userlogin?ticketerror=" + errorMessage;
//
//		}
//	}
	
	


	@PostMapping("ticket")
	public String printTicket(HttpSession session, @RequestParam Integer id, Model model) {
	    String username = (String) session.getAttribute("loggedInUser");

	    if (username != null && !username.equals("Empty")) {
	        System.out.println("Booking flight ID: " + id + " for user: " + username);
//
//	        FlightDetails flight = allFlightservice.getFlightById(id);
//	        if (flight != null) {
//	            BookingRecord booking = new BookingRecord();
//	            booking.setUsername(username);
//	            booking.setFlight(flight);
//	            bookingRecordservice.saveUserBokiings(booking);
//	        }

	        model.addAttribute("flightId", id);
	        model.addAttribute("username", username);
	        return "ticket";
	    } else {
	        String errorMessage = "To book, user login is compulsory";
	        return "redirect:" + gatewayBaseUrl + "/Userlogin?ticketerror=" + errorMessage;
	    }
	}

	
	

}