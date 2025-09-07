package com.flightmanagement.updateservice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.updateservice.model.FlightDetails;
import com.flightmanagement.updateservice.repository.UpdateServiceRepository;

@Service
public class UpdateFlightService {

	@Autowired
	private UpdateServiceRepository flightRepository;

	public FlightDetails saveOrUpdateFlight(FlightDetails flight, int oldFlightId) {
		FlightDetails existingFlight = flightRepository.findById(flight.getId()).orElse(new FlightDetails());
		if ((flight.getId() != oldFlightId) && (existingFlight.getId() == 0)) {
			flightRepository.updateExistingFlight(flight, oldFlightId);
			return flight;
		} else if (flight.getId() == oldFlightId) {

			return flightRepository.save(flight);

		} else {
			return null; // Updates if ID exists

		}

	}

	public FlightDetails findByFlightId(Integer id) {
		return flightRepository.findById(id).get();
	}

}
