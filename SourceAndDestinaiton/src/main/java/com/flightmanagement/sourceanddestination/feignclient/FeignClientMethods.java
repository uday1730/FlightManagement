package com.flightmanagement.sourceanddestination.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.flightmanagement.sourceanddestination.model.FlightDetails;

@FeignClient("ALLFLIGHTINFOSERVICE")
public interface FeignClientMethods {
	@GetMapping("allflightinfoapi/flightById")
	public FlightDetails getFlightById(@RequestParam Integer id);
}
