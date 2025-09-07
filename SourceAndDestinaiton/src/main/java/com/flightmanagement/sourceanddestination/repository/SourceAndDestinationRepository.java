package com.flightmanagement.sourceanddestination.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.flightmanagement.sourceanddestination.model.FlightDetails;

import java.util.List;

@Repository
public interface SourceAndDestinationRepository extends JpaRepository<FlightDetails, Integer> {
	
    List<FlightDetails> findBySourceAndDestination(String source, String destination);
    
    List<FlightDetails> findBySource(String source);
    
    List<FlightDetails> findByDestination(String destination);
    
    
}
