package com.flightmanagement.updateservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.flightmanagement.updateservice.model.FlightDetails;

@Repository
public interface UpdateServiceRepository extends JpaRepository<FlightDetails, Integer> {

	@Modifying
    @Transactional
    @Query(value = "UPDATE flight_info SET " +
           "Flight_Id = :#{#flight.id}, " +
           "Flight_Name = :#{#flight.name}, " +
           "Source_City = :#{#flight.source}, " +
           "Destination_City = :#{#flight.destination}, " +
           "Flight_Type = :#{#flight.type}, " +
           "Fare = :#{#flight.fare}, " +
           "Date_Of_Journey = :#{#flight.date}, " +
           "Departure_Time = :#{#flight.departure}, " +
           "Arrival_Time = :#{#flight.arrival}, " +
           "Duration_Of_Journey = :#{#flight.duration} " +
           "WHERE Flight_Id = :oldFlightId", nativeQuery = true)
    void updateExistingFlight(@Param("flight") FlightDetails flight, @Param("oldFlightId") int oldFlightId);

	
//	@Query(value="select f.* from flight_info f where f.flight_id=:id", nativeQuery = true)
//	FlightDetails findById(int id);

}
