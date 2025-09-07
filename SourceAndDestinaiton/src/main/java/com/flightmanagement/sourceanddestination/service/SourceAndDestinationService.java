package com.flightmanagement.sourceanddestination.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.flightmanagement.sourceanddestination.model.FlightDetails;
import com.flightmanagement.sourceanddestination.repository.SourceAndDestinationRepository;

@Service
public class SourceAndDestinationService {

	@Autowired
	private SourceAndDestinationRepository sdRepository;

	public ResponseEntity<List<FlightDetails>> searchFlightsBySourceAndDestination(String source,
			String destination) {

		List<FlightDetails> flights = new ArrayList<>();
		
		System.out.println(source);
		System.out.println(destination);

		if (source != null && !source.isEmpty() && destination != null && !destination.isEmpty()) {
			flights = sdRepository.findBySourceAndDestination(source, destination);
		} else if ((source != null && !source.isEmpty()) && (destination == null || destination.isEmpty())) {
			flights = sdRepository.findBySource(source);
		} else if ((destination != null && !destination.isEmpty()) && (source == null || source.isEmpty())) {
			flights = sdRepository.findByDestination(destination);
		} else if(source == null || source.isEmpty() && destination == null || destination.isEmpty()){
			return new ResponseEntity<>(HttpStatus.GONE);
		}else {
			
		}
		if(flights.size() == 0) {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<>(flights, HttpStatus.OK);
	}

	public FlightDetails getFlightById(int id){
		return sdRepository.findById(id).get();
	}
}
