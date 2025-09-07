package com.flightmanagement.deleteflight.repository;



import org.springframework.data.jpa.repository.JpaRepository;

import com.flightmanagement.deleteflight.model.FlightDetails;



public interface DeleteFlightRepository extends JpaRepository<FlightDetails, Integer> {
}
