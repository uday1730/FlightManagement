package com.flightmanagement.allflightinfo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.flightmanagement.allflightinfo.model.FlightDetails;

@Repository
public interface AllFlightInfoRepository extends JpaRepository<FlightDetails, Integer> {
	
}
