package com.flightmanagement.updateservice.feignclient;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

import com.flightmanagement.updateservice.model.FlightDetails;

@FeignClient("ALLFLIGHTINFOSERVICE")
public interface FeignClientMethods {

	@GetMapping("allflightinfoapi/allFlights")
	public ResponseEntity<List<FlightDetails>> getAllFlights();
}