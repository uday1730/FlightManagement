package com.flightmanagement.deleteflight.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.deleteflight.model.FlightDetails;
import com.flightmanagement.deleteflight.repository.DeleteFlightRepository;



@Service
public class DeleteFlightService {

    @Autowired
    private DeleteFlightRepository flightRepository;

  
    public void saveFlight(FlightDetails flight) {
        flightRepository.save(flight);
    }


    public FlightDetails getFlightById(int id) {
        return flightRepository.findById(id).orElse(null);
    }

    
    public void deleteFlightById(int id) {
        flightRepository.deleteById(id);
    }
}
