package com.flightmanagement.updateservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class UpdateServiceMain {
    public static void main(String[] args) {
        SpringApplication.run(UpdateServiceMain.class, args);
    }
}
