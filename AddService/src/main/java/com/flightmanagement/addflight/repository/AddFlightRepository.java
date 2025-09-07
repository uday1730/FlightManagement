package com.flightmanagement.addflight.repository;



import org.springframework.data.jpa.repository.JpaRepository;

import com.flightmanagement.addflight.model.FlightDetails;


public interface AddFlightRepository extends JpaRepository<FlightDetails, Integer> {
}
