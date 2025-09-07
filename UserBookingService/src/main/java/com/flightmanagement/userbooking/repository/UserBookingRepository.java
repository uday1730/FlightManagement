package com.flightmanagement.userbooking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.flightmanagement.userbooking.model.BookingRecord;

@Repository
public interface UserBookingRepository extends JpaRepository<BookingRecord, Integer> {
	
	List<BookingRecord> findByUsername(String username);

}
