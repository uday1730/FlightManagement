package com.flightmanagement.updateservice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flightmanagement.updateservice.feignclient.FeignClientMethods;
import com.flightmanagement.updateservice.model.FlightDetails;
import com.flightmanagement.updateservice.service.UpdateFlightService;

import jakarta.servlet.http.HttpSession;


@Controller
public class UpdateServiceController {

    @Autowired
    private UpdateFlightService flightService;
    
    @Autowired
    private FeignClientMethods feignClientMethods;
    
    @GetMapping("/updateapi/flights")
    @ResponseBody
    public ResponseEntity<List<FlightDetails>> getFlightsViaFeign() {
    	System.out.println("In feign");
        return feignClientMethods.getAllFlights();
    }

	@GetMapping("/updateFlight")
	public String showFlightForm(@RequestHeader(value = "X-Username", required = false) String username,
			HttpSession session) {

		if (username != null && !username.equals("Empty")) {
			session.setAttribute("loggedInUser", username);
			System.out.println("Username in AllFlightInfo: " + username);
		} else {
			System.out.println("No username found in header. Showing guest view.");
		}
		return "allflightsinupdate";

	}
    
    @PostMapping("/updateFlight")
    public String updateFlightDetails(@RequestParam int id, Model model) {
    	FlightDetails flightObj = flightService.findByFlightId(id);
    	model.addAttribute("flightObj", flightObj);
    	System.out.println(flightObj.toString());
        return "updatepage";
    }
    
    @PostMapping("/submitFlight")
    public String submitFlight(@ModelAttribute FlightDetails flight,
                               @RequestParam int oldFlightId,
                               Model model) {
        FlightDetails checkExisting=flightService.saveOrUpdateFlight(flight, oldFlightId);
        if(checkExisting==null) {
        	
        	model.addAttribute("message", "Flight Id already exits");
        }
        else {
        	model.addAttribute("message", "Successfully Updated");
        }
        
        model.addAttribute("flightObj", flight);
        return "updatepage";
    }
    
   

}
