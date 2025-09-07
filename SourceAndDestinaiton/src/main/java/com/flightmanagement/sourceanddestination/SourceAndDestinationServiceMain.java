package com.flightmanagement.sourceanddestination;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients(basePackages = "com.flightmanagement.sourceanddestination.feignclient")
public class SourceAndDestinationServiceMain {
	public static void main(String[] args) {
		SpringApplication.run(SourceAndDestinationServiceMain.class, args);
	}
}
