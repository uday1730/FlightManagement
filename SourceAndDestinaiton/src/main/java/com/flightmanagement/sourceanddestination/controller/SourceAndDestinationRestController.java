package com.flightmanagement.sourceanddestination.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.flightmanagement.sourceanddestination.model.FlightDetails;
import com.flightmanagement.sourceanddestination.service.SourceAndDestinationService;

@RestController
@RequestMapping("sourceAndDestinationapi")
public class SourceAndDestinationRestController {
	
	@Autowired
	private SourceAndDestinationService service;
	
	@PostMapping("sourceAndDestination")
	public ResponseEntity<List<FlightDetails>> getFlightsFromSourceAndDestination(@RequestParam String source, @RequestParam String destination) {
		System.out.println("IN post");
		return service.searchFlightsBySourceAndDestination(source, destination);
	}
	
//	 @GetMapping("sourceAndDestination")
//	    public ResponseEntity<List<FlightDetails>> getFlightsViaGet(@RequestParam String source, @RequestParam String destination) {
//	     ResponseEntity<List<FlightDetails>> temp=service.searchFlightsBySourceAndDestination(source, destination);
//	     
//	     System.out.println("the temp is"+temp.toString());
//		 return service.searchFlightsBySourceAndDestination(source, destination);
//	 }
	 
	 @GetMapping("flightByIdSD")
	public FlightDetails getFlightById(@RequestParam Integer id) {
	    FlightDetails flightDetail = service.getFlightById(id);
		return flightDetail;
	}
}
