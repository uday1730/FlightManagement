package com.flightmanagement.allflightinfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flightmanagement.allflightinfo.model.BookingRecord;
import com.flightmanagement.allflightinfo.repository.BookingRecordRepository;

@Service
public class BookingRecordService {
	
	@Autowired
	private BookingRecordRepository bookingRecordRepository;
	
	
	public void saveUserBokiings(BookingRecord booking) {
	   bookingRecordRepository.save(booking);
	}

}
