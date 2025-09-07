package com.flightmanagement.allflightinfo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.flightmanagement.allflightinfo.model.BookingRecord;

@Repository
public interface BookingRecordRepository extends JpaRepository<BookingRecord, Integer>{

}
