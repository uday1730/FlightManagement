package com.flightmanagement.allflightinfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.allflightinfo.model.FlightDetails;
import com.flightmanagement.allflightinfo.repository.AllFlightInfoRepository;


@Service
public class AllFlightInfoService {
	
	@Autowired
	private AllFlightInfoRepository flightrepo;
	
	
	public List<FlightDetails> getAllFlights() {
	    return flightrepo.findAll();
	}
	
	public FlightDetails getFlightById(int id){
		return flightrepo.findById(id).orElse(null);
	}

}
