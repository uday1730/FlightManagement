package com.flightmanagement.deleteflight;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class DeleteflightMain {
    public static void main(String[] args) {
        SpringApplication.run(DeleteflightMain.class, args);
    }
}
