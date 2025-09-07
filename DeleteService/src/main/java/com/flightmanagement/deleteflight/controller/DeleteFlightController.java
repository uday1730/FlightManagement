package com.flightmanagement.deleteflight.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.flightmanagement.deleteflight.model.FlightDetails;
import com.flightmanagement.deleteflight.service.DeleteFlightService;

@Controller
public class DeleteFlightController {

    @Autowired
    private DeleteFlightService flightService;
    
    
    @GetMapping("/deleteFlight")
    public String showFlightForm() {
        return "deleteflightdetails";
    }
    
	
	    @PostMapping("/deleteFlight")
	    public String deleteFlight(@RequestParam("id") int id, Model model) {
	    	System.out.println("The Id is "+id);
	    	FlightDetails flight = flightService.getFlightById(id);
	        if (flight != null) {
	            flightService.deleteFlightById(id);
	            model.addAttribute("message", "Flight deleted successfully.");
	        } else {
	            model.addAttribute("error", "Flight ID not found.");
	        }
	        return "deleteflightdetails";
	    }
}

