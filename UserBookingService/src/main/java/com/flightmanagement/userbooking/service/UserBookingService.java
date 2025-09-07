package com.flightmanagement.userbooking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.userbooking.model.BookingRecord;
import com.flightmanagement.userbooking.repository.UserBookingRepository;



@Service
public class UserBookingService {
	
	 @Autowired
	    private UserBookingRepository userBookingRepository;
	 
	 public List<BookingRecord> getUsername(String username){
		 
		 return userBookingRepository.findByUsername(username);
	 }

}
