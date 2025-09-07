package com.flightmanagement.userservice.service;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;

import com.flightmanagement.userservice.model.UserLoginDetails;
import com.flightmanagement.userservice.repository.UserRepository;



@Component
public class UserService {
	
	@Autowired
	private UserRepository userrepo;
	

	


	
	public boolean isStrongPassword(String password) {
	    String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";
	    return password.matches(pattern);
	}
	
	
	
	public UserLoginDetails getUserAndPassword(String username,String password,String checkadminuser) {
		return userrepo.findByUsernameAndPasswordAndCheckAdminUser(username, password,checkadminuser);
	
	}
	
	public Optional<UserLoginDetails> getByUsername(String username) {
		return userrepo.findById(username);
	
	}
	
	public void toSaveUserDetails(UserLoginDetails user) {
		userrepo.save(user);
	
	}
	}

