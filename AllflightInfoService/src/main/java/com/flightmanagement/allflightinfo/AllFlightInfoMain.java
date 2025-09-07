package com.flightmanagement.allflightinfo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class AllFlightInfoMain {

	public static void main(String[] args) {

		SpringApplication.run(AllFlightInfoMain.class, args);

	}

}
