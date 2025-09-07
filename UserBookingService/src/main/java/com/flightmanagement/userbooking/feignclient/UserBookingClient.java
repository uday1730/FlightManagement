package com.flightmanagement.userbooking.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@FeignClient(name = "mainpage", url = "http://localhost:7770")
public interface UserBookingClient {
    @GetMapping("/homePage/username")
    String getusername();
}





