package com.flightmanagement.userservice.model;


import org.springframework.stereotype.Component;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="logindetails")
@Component
public class UserLoginDetails {
	
	@Id
	private String username;
	private String password;
	private String checkAdminUser;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCheckAdminUser() {
		return checkAdminUser;
	}
	public void setCheckAdminUser(String checkAdminUser) {
		this.checkAdminUser = checkAdminUser;
	}

}

