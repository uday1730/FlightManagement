package com.flightmanagement.addflight.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.addflight.model.FlightDetails;
import com.flightmanagement.addflight.repository.AddFlightRepository;


@Service
public class AddFlightService {

    @Autowired
    private AddFlightRepository flightRepository;

 
    public void saveFlight(FlightDetails flight) {
        flightRepository.save(flight);
    }
    
    public boolean getFlightID(int id) {
 
		return flightRepository.findById(id).isPresent();
    }
    
}
