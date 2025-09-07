package com.flightmanagement.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "USERSERVICE") 
public interface UserServiceClient {

    @GetMapping("/user/checkAdmin")
    Boolean isAdmin(@RequestParam("username") String username);
}

