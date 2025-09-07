package com.flightmanagement.userservice.UserController;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flightmanagement.userservice.model.UserLoginDetails;
import com.flightmanagement.userservice.service.UserService;
import com.flightmanagement.userservice.util.JwtUtil;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private JwtUtil jwtUtil;

	@Value("${gateway.base.url}")
	private String gatewayBaseUrl;

	@GetMapping("/UsersignUp")
	public String signUp() {
		return "signup";
	}

	@PostMapping("/UsersignUp")
	public String signUp(@RequestParam String username, @RequestParam String password,
			@RequestParam String passwordcheck, @RequestParam String checkadminuser, HttpSession session) {

		// Check if username already exists
		Optional<UserLoginDetails> existingUser = userService.getByUsername(username);

		if (!password.equals(passwordcheck)) {
			session.setAttribute("error", "Passwords do not match");
			return "redirect:" + gatewayBaseUrl + "/UsersignUp";
		}

		if (!userService.isStrongPassword(password)) {
			session.setAttribute("error",
					"Password must be 8+ characters with uppercase, lowercase, digit, and special character");
			return "redirect:" + gatewayBaseUrl + "/UsersignUp";
		}

		if (existingUser.isPresent() || username.length() <= 4) {
			session.setAttribute("error", "Username must be over 4 characters and not already taken");
			return "redirect:" + gatewayBaseUrl + "/UsersignUp";
		}

		// Create and save new user
		UserLoginDetails newUser = new UserLoginDetails();
		newUser.setUsername(username);
		newUser.setPassword(password); // Consider encrypting this before saving
		newUser.setCheckAdminUser(checkadminuser);
		userService.toSaveUserDetails(newUser);

		session.setAttribute("signin", "User signed up successfully");
		return "redirect:" + gatewayBaseUrl + "/Userlogin";

	}

	@GetMapping("/user/checkAdmin")
	public ResponseEntity<Boolean> checkAdmin(@RequestParam String username) {
		UserLoginDetails user = userService.getByUsername(username).get();
		boolean isAdmin = user != null && "admin".equalsIgnoreCase(user.getCheckAdminUser());
		return ResponseEntity.ok(isAdmin);
	}

	@GetMapping("/Userlogin")
	public String loginPage(@RequestHeader(value = "X-Username", required = false) String username,
			HttpSession session) {
		if (username != null && !username.equals("Empty")) {
			session.setAttribute("loggedInUser", username);
			System.out.println("Username in AllFlightInfo: " + username);
		} else {
			System.out.println("No username found in header. Showing guest view.");
		}
		return "login";
	}

	@PostMapping("/Userlogin")
	@ResponseBody
	public ResponseEntity<?> login(@RequestParam String username, @RequestParam String password,
			@RequestParam String checkadminuser) {
		System.out.println("the admin is " + checkadminuser);
		UserLoginDetails user = userService.getUserAndPassword(username, password, checkadminuser);
		if (user != null) {
			String token = jwtUtil.generateToken(user.getUsername());
			System.out.println("The username " + username);
			System.out.println("the admin is " + checkadminuser);
			return ResponseEntity.ok(Map.of("token", token));
		} else {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // Clear session
		return "redirect:" + gatewayBaseUrl + "/homePage";
	}

}
