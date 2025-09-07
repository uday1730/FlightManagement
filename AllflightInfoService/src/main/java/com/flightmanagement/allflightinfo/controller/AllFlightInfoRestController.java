package com.flightmanagement.allflightinfo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.flightmanagement.allflightinfo.model.FlightDetails;
import com.flightmanagement.allflightinfo.service.AllFlightInfoService;

@RestController
@RequestMapping("allflightinfoapi")
public class AllFlightInfoRestController {

	@Autowired
	private AllFlightInfoService flightService;

	@GetMapping("allFlights")
	public ResponseEntity<List<FlightDetails>> getAllFlights() {
		List<FlightDetails> allFlights = flightService.getAllFlights();
		return new ResponseEntity<>(allFlights, HttpStatus.OK);
	}
	
	@GetMapping("flightById")
	public FlightDetails getFlightById(@RequestParam Integer id) {
	    FlightDetails flightDetail = flightService.getFlightById(id);
		System.out.println(flightDetail);
		return flightDetail;
	}
}
