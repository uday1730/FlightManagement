package com.flightmanagement.userplan.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.userplan.model.FlightDetails;
import com.flightmanagement.userplan.repository.UserPlanRepository;

@Service
public class UserPlanService {

	@Autowired
	private UserPlanRepository userplanrepo;

	public List<FlightDetails> getSourceDestination() {
		return userplanrepo.findAll();
	}

	public List<FlightDetails> getSourceDestinationFare(String source, String destination, int fare) {
		return userplanrepo.findBySourceAndDestinationWithMaxFare(source, destination, fare);
	}

	public List<String> findSourcesContaining(String query) {
	    List<String> result = userplanrepo.findBySourceContainingIgnoreCase(query).stream()
	        .map(flight -> flight.getSource().trim())
	        .distinct()
	        .collect(Collectors.toList());
	    Set<String> setResult = new HashSet<>(result);
	    result = new ArrayList<>(setResult);
	    System.out.println(result);
	    return result;
	}
	
	public FlightDetails getFlightById(int id){
		return userplanrepo.findById(id).get();
	}



	public List<String> findDestinationsContaining(String query) {
		List<String> result = userplanrepo.findByDestinationContainingIgnoreCase(query).stream()
			    .map(flight -> flight.getDestination().trim())
			    .distinct()
			    .collect(Collectors.toList());
		Set<String> setResult = new HashSet<>(result);
	    result = new ArrayList<>(setResult);
	    System.out.println(result);
	    return result;
	}

}
