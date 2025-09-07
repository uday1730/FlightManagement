<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%
    // Read theme from cookie (set by JavaScript based on localStorage)
    String theme = "light"; // fallback
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("theme".equals(cookie.getName())) {
                theme = cookie.getValue();
                break;
            }
        }
    }
    String cssPath = theme.equals("dark") ? "/allcssforupdate/updatepagecss/updatepagedark.css" : "/allcssforupdate/updatepagecss/updatepagelight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="description" content="Flight Management System main page with theme support" />
  <title>Add Flight</title>

    <!-- Set cookie from localStorage before page renders -->
    <script>
        (function() {
            const theme = localStorage.getItem("theme") || "light";
            document.cookie = "theme=" + theme + "; path=/";
        })();
    </script>

    <!-- Load theme immediately via server-side logic -->
    <link rel="stylesheet" href="<%= cssPath %>" id="theme-link" />
</head>
<body>

	<header class="site-header">
		<nav class="navbar">
			<div class="nav-left" onclick="window.location.href='/homePage';">
				<img class="logo" src="/imageresources/airplane-mode.png"
					alt="Flight Management Logo">
				<div class="site-title">
					<div class="brand">Flight Management</div>
					<div class="sub">System</div>
				</div>
			</div>

			<div class="nav-center">
				<a class="home-pill hover-pill" href="/homePage" aria-label="Home">
					Home</a>
			</div>

			<div class="nav-right" aria-label="Quick options">
				<button id="theme-toggle" class="theme-toggle-btn hover-pill"
					aria-label="Toggle dark mode" onclick="toggleDarkMode()">
					<span class="icon light-icon">☀️</span> <span
						class="icon dark-icon" style="display: none;">🌙</span>
				</button>
				<a href="/bookings" class="pill hover-pill" title="My Bookings">My
					Bookings</a>
				<%
				String loggedInUser = (String) session.getAttribute("loggedInUser");
				if (loggedInUser == null) {
				%>
				<a href="/Userlogin" class="pill hover-pill" title="Login">Login</a>
				<%
				} else {
				%>
					<div class="dropdown" onclick="toggleDropdown()">
					    <button class="dropdown-toggle"  aria-expanded="false">
					        <div style="display: flex; align-items: center;">
					            <img class="userlogo" src="/imageresources/user.png" alt="User Logo">
					            <div style="margin-left: 8px;"><%=loggedInUser%> ▼</div>
					        </div>
					    </button>
					    <div id="dropdown-menu" class="dropdown-menu">
					        <a href="#" class="logout-link" onclick="handleLogout()" title="Sign Out">Sign Out</a>
					    </div>
					</div>
				<%
				}
				%>
			</div>
		</nav>
	</header>

    
    <!-- ------------------------------- -->
    
	    <div class="form-title">Update an existing flight</div>
	
	    <div class="form-submit-container">
	        <form class="form-container" id="flightForm" action="submitFlight" method="post">
	        	<input type="hidden" name="oldFlightId" value="${flightObj.id}" />
	            <div class="form-row">
					<div class="label-title"><label class ="label-title-text" for="id">Flight ID:</label></div>
					<div class="input-title"><input type="number" id="id" name="id" placeholder="Enter flight id" value="${flightObj.id > 0 ? flightObj.id : ''}"  required /></div>
				</div>
	            
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="name">Flight Name:</label></div>
	                <div class="input-title"><input type="text" id="name" name="name" placeholder="Enter flight name" value="${not empty flightObj.name ? flightObj.name : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="source">Source:</label></div>
	                <div class="input-title"><input type="text" id="source" name="source" placeholder="Enter source" value="${not empty flightObj.source ? flightObj.source : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="destination">Destination:</label></div>
	                <div class="input-title"><input type="text" id="destination" name="destination" name="id" placeholder="Enter destination" value="${not empty flightObj.destination ? flightObj.destination : ''}" required /></div>
	            </div>
	            
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="type">Type:</label></div>
	                <div class="input-title"><input type="text" id="type" name="type" id="id" name="id" placeholder="Enter type of flight" value="${not empty flightObj.type ? flightObj.type : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="fare">Fare:</label></div>
	                <div class="input-title"><input type="number" id="fare" name="fare" min="1" placeholder="Enter fare" value="${flightObj.fare != 0 ? flightObj.fare : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="date">Date:</label></div>
	                <div class="input-title"><input type="date" id="date" name="date" placeholder="Enter journey date" value="${not empty flightObj.date ? flightObj.date : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="departure">Departure Time:</label></div>
	                <div class="input-title"><input type="time" id="departure" name="departure" placeholder="Enter departure time" value="${not empty flightObj.departure ? flightObj.departure : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="arrival">Arrival Time</label></div>
	                <div class="input-title"><input type="time" id="arrival" name="arrival" placeholder="Enter arrival time" value="${not empty flightObj.arrival ? flightObj.arrival : ''}" required /></div>
	            </div>
	
	            <div class="form-row">
	                <div class="label-title"><label class ="label-title-text" for="duration">Duration:</label></div>
	                <div class="input-title"><input type="time" id="duration" name="duration" placeholder="Enter duration time" /></div>
	            </div>
	        </form>
	        <button class="submit-btn" type="submit" form="flightForm">Submit Flight</button>
	        <c:if test="${not empty message}">
				<text class="status-message">${message}</text>
			</c:if>
	    </div>
    
    <!-- ------------------------------- -->

	<script>
		function toggleDropdown() {
		    const menu = document.getElementById("dropdown-menu");
		    menu.classList.toggle("show");
		}
		
		window.onclick = function(event) {
		    if (!event.target.matches('.dropdown-toggle')) {
		        const dropdowns = document.getElementsByClassName("dropdown-menu");
		        for (let i = 0; i < dropdowns.length; i++) {
		            dropdowns[i].classList.remove('show');
		        }
		    }
		};
		
		
		 // Apply saved theme on page load
	    window.addEventListener('load', () => {
	        const savedTheme = localStorage.getItem('theme');
	        const themeLink = document.getElementById('theme-link');
	        const lightIcon = document.querySelector('.light-icon');
	        const darkIcon = document.querySelector('.dark-icon');

	        if (savedTheme === 'dark') {
	            themeLink.setAttribute('href', '/allcssforupdate/updatepagecss/updatepagedark.css');
	            lightIcon.style.display = 'none';
	            darkIcon.style.display = 'inline';
	        } else {
	            themeLink.setAttribute('href', '/allcssforupdate/updatepagecss/updatepagelight.css');
	            lightIcon.style.display = 'inline';
	            darkIcon.style.display = 'none';
	        }
	    });



	  const themeLink = document.getElementById('theme-link');
	  function toggleDarkMode() {
		    const themeLink = document.getElementById('theme-link');
		    const button = document.getElementById('theme-toggle');
		    const lightIcon = document.querySelector('.light-icon');
		    const darkIcon = document.querySelector('.dark-icon');
		    const currentTheme = themeLink.getAttribute('href');

		    const lightTheme = '/allcssforupdate/updatepagecss/updatepagelight.css';
		    const darkTheme = '/allcssforupdate/updatepagecss/updatepagedark.css';

		    if (currentTheme === lightTheme) {
		        themeLink.setAttribute('href', darkTheme);
		        button.style.backgroundColor = 'transparent';
		        if (lightIcon) lightIcon.style.display = 'none';
		        if (darkIcon) darkIcon.style.display = 'inline';
		        localStorage.setItem('theme', 'dark'); 
		    } else {
		        themeLink.setAttribute('href', lightTheme);
		        button.style.backgroundColor = 'white';
		        if (lightIcon) lightIcon.style.display = 'inline';
		        if (darkIcon) darkIcon.style.display = 'none';
		        localStorage.setItem('theme', 'light'); 
		    }
		}


	  
	  
	  function toggleDropdown() {
	        const dropdownMenu = document.getElementById("dropdown-menu");
	        dropdownMenu.classList.toggle("show");
	    }

	    document.addEventListener("click", function (event) {
	    	const toggleButton = document.querySelector(".dropdown-toggle");
	        const dropdownMenu = document.getElementById("dropdown-menu");
	        const logoutLink = document.getElementById("logout-link");
	        

	        if (logoutLink && !logoutLink.contains(event.target) && dropdownMenu.classList.contains("show")) {
	            logoutLink.style.display = "none"; 
	            dropdownMenu.classList.remove("show");
	        }
	    });
	  
	  
	  function handleLogout() {
   		  localStorage.removeItem("jwt");
   		  window.location.href = window.location.origin.replace(/:\d+/, ":3336") + "/logout";
   		}
	 

    </script>
	
</body>
</html>
