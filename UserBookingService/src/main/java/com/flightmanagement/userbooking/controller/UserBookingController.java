package com.flightmanagement.userbooking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.flightmanagement.userbooking.feignclient.UserBookingClient;
import com.flightmanagement.userbooking.service.UserBookingService;

@Controller
public class UserBookingController {

    @Autowired
    private UserBookingService userBookingService;
    
    @Autowired
    private UserBookingClient userBookingClient;

    @GetMapping("/bookings")
    public String getBookedFlights(Model model) {
        
    //	userBookingClient.getusername();
       
            return "bookings"; // JSP page
       
    }
}
