package com.flightmanagement.userplan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.flightmanagement.userplan.model.FlightDetails;
import com.flightmanagement.userplan.service.UserPlanService;

@RestController
@RequestMapping("userplanapi")
public class UserPlanRestController {
	
	@Autowired
	private UserPlanService service;
	
	@GetMapping("flightByIdUL")
	public FlightDetails getFlightById(@RequestParam Integer id) {
	    FlightDetails flightDetail = service.getFlightById(id);
		return flightDetail;
	}
}
