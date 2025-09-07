package com.flightmanagement.userservice.repository;

import org.springframework.stereotype.Repository;

import com.flightmanagement.userservice.model.UserLoginDetails;

import org.springframework.data.jpa.repository.JpaRepository;


@Repository
public interface UserRepository  extends JpaRepository<UserLoginDetails, String> {

	
	UserLoginDetails findByUsernameAndPasswordAndCheckAdminUser(String username, String password, String checkAdminUser);

	

}
