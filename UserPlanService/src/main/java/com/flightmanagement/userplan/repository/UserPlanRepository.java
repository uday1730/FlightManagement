package com.flightmanagement.userplan.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.flightmanagement.userplan.model.FlightDetails;

@Repository
public interface UserPlanRepository extends JpaRepository<FlightDetails, Integer> {

	@Query("SELECT f FROM FlightDetails f WHERE f.source = :source AND f.destination = :destination AND f.fare <= :fare")
	List<FlightDetails> findBySourceAndDestinationWithMaxFare(String source,
	                                                          String destination,
	                                                          int fare);
	
	List<FlightDetails> findBySourceContainingIgnoreCase(String keyword);
	
	List<FlightDetails> findByDestinationContainingIgnoreCase(String keyword);
}
