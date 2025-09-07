<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.flightmanagement.updateservice.model.FlightDetails"%>

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
    String cssPath = theme.equals("dark") ? "/allcssforupdate/allflightinfocss/allflightinfodark.css" : "/allcssforupdate/allflightinfocss/allflightinfolight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="description" content="Flight Management System main page with theme support" />
    <title>Flight Details</title>

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
					<div class="dropdown">
					    <button class="dropdown-toggle" onclick="toggleDropdown()" aria-expanded="false">
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
	<div class="table-container">
        <div class="body-head-titles">
          <a href="/homePage" class="back-button">← Back </a>
            <h2 id="flight-details-title" class="flight-details-title">Flight Details</h2>
          <div style="width: 120px;"></div>
        </div>

        <div id="flight-card-container" class="flight-card-container">
            
        </div>
    </div>
    
	    
	<script> 
		fetch('/updateapi/flights')
    	.then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(flights => {
            const container = document.getElementById('flight-card-container');
            if (!flights || flights.length === 0) {
                container.innerHTML = "<p style='text-align: center;'>No flight details available</p>";
            } else {
                flights.forEach(flight => {
                	
                	const flightIdStr = String(flight.id);
                	const airlineNameStr = String(flight.name);
                	const flightTypeStr = String(flight.type);

                	const flightDateStr = String(flight.date);
                	const flightSourceStr = String(flight.source);
                	const flightDestinationStr = String(flight.destination);

                	const departureTimeStr = String(flight.departure);
                	const arrivalTimeStr = String(flight.arrival);
                	const flightDurationStr = String(flight.duration);

                	const flightFare = flight.fare;
                	
                	let logoUrl = '';

                	// Check the airline name and assign the correct URL
                	if (airlineNameStr === "Air India") {
                	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/AI.png?v=20";
                	} else if (airlineNameStr === "SpiceJet") {
                	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/SG.png?v=20";
                	} else if (airlineNameStr === "IndiGo") {
                	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/6E.png?v=20";
                	} else if (airlineNameStr === "Akasa Air") {
                	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/QP.png?v=20";
                	} else {
                	    // A default URL or a blank string if the airline is not found
                	    logoUrl = "https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/6E.png?v=20";
                	}

                	// Create a formatter for Indian Rupees
                	const inrFormatter = new Intl.NumberFormat('en-IN', {
                	  style: 'currency',
                	  currency: 'INR',
                	  minimumFractionDigits: 0, 
                	});

                	const flightFareStr = inrFormatter.format(flightFare);
                	
                	const modifiedDepartureTimeStr = departureTimeStr.slice(0, -3);
                	const modifiedarrivalTimeStr = arrivalTimeStr.slice(0, -3);
                	
                	const parts = flightDurationStr.split(':'); 
              
                	const formattedDuration = `\${parts[0]} h \${parts[1]} m`;

    				
                    const cardHtml = `
                    	<div class="flight-card">
	                        <div class="flight-info-left">
	                            <div class="airline-details">
	                                <div class="airline-logo"
	                                    style="background-image: url('\${logoUrl}');"></div>
	                                <div class="date-id-name-div">
	                                    <p class="journey-date">\${flightDateStr}</p>
	                                    <p class="airline-name">\${airlineNameStr}</p>
	                                    <p class="flight-id">\${flightIdStr}</p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="flight-info-middle">
	                            <div class="timing-details">
	                                <div class="time-city">
	                                    <h3>\${modifiedDepartureTimeStr}</h3>
	                                    <p>\${flightSourceStr}</p>
	                                </div>
	                                <div class="flight-divider">
	                                    <span class="duration-text">\${formattedDuration}</span>
	                                    <hr class="flight-line">
	                                    <span class="flight-label">\${flightTypeStr}</span>
	                                </div>
	                                <div class="time-city">
	                                    <h3>\${modifiedarrivalTimeStr}</h3>
	                                    <p>\${flightDestinationStr}</p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="flight-info-right">
	                            <div class="price-and-book">
	                                <span class="price-display">\${flightFareStr}</span>
	                                <button class="book-button" onclick="submitFlight('\${flightIdStr}')">Update</button>
	                            </div>
	                        </div>
	                  	</div>
					`;
                    container.innerHTML += cardHtml;
                });
            }
        })
        .catch(error => {
            console.error("Error fetching flight data:", error);
            const container = document.getElementById('flight-card-container');
            container.innerHTML = "<p style='text-align: center; color: black;'>Error loading data. Please check your network and try again.</p>";
        });
	    
		function submitFlight(id) {
	    	console.log(id);
	    	const form = document.createElement('form');
	    	form.method = 'POST';
	        form.action = `/updateFlight`;
	     
	        const input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'id';
	        input.value = id;

	        form.appendChild(input);
	        document.body.appendChild(form);
	        form.submit();
	    }
	
		
		
	 // Apply saved theme on page load
    window.addEventListener('load', () => {
        const savedTheme = localStorage.getItem('theme');
        const themeLink = document.getElementById('theme-link');
        const lightIcon = document.querySelector('.light-icon');
        const darkIcon = document.querySelector('.dark-icon');

        if (savedTheme === 'dark') {
            themeLink.setAttribute('href', '/allcssforupdate/allflightinfocss/allflightinfodark.css');
            lightIcon.style.display = 'none';
            darkIcon.style.display = 'inline';
        } else {
            themeLink.setAttribute('href', '/allcssforupdate/allflightinfocss/allflightinfolight.css');
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

	    const lightTheme = '/allcssforupdate/allflightinfocss/allflightinfolight.css';
	    const darkTheme = '/allcssforupdate/allflightinfocss/allflightinfodark.css';

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
  
  
  
  
//Check if JWT exists in localStorage
	  const token = localStorage.getItem("jwt");

	  if (token) {
	    fetch("/updateFlight", {
	      method: "GET",
	      headers: {
	        "Authorization": "Bearer " + token
	      }
	    })
	    .then(res => res.text())
	    .then(html => {
	      document.open();
	      document.write(html);
	      document.close();
	    })
	    .catch(err => {
	      console.error("Failed to load authenticated home page:", err);
	    });
	  }
	  
	  
		function toggleDropdown() {
    		const menu = document.getElementById("dropdown-menu");
    		menu.classList.toggle("show");
    	}
	  
	  
	  function handleLogout() {
   		  localStorage.removeItem("jwt");
   		  window.location.href = window.location.origin.replace(/:\d+/, ":3336") + "/logout";
   		}

    </script>

</body>
</html>
