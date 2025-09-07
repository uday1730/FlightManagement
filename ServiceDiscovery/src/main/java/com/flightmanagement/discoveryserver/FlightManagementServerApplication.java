package com.flightmanagement.discoveryserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class FlightManagementServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(FlightManagementServerApplication.class, args);
	}

}
