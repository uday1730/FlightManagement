<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
String cssPath = theme.equals("dark")
		? "/sourceanddestinationcss/sourceanddestinationdark.css"
		: "/sourceanddestinationcss/sourceanddestinationlight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<meta name="description"
	content="Flight Management System main page with theme support" />
<title>Flight Source/Destination</title>

<!-- Set cookie from localStorage before page renders -->
<script>
        (function() {
            const theme = localStorage.getItem("theme") || "light";
            document.cookie = "theme=" + theme + "; path=/";
        })();
    </script>

<!-- Load theme immediately via server-side logic -->
<link rel="stylesheet" href="<%=cssPath%>" id="theme-link" />
</head>


<body>

	<div id="headerContent">

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
					<div id="loginSection">
						<%
						String loggedInUser = (String) session.getAttribute("loggedInUser");
						if (loggedInUser == null) {
						%>
						<a href="/Userlogin" class="pill hover-pill" title="Login">Login</a>
						<%
						} else {
						%>
						<div class="dropdown">
							<button class="dropdown-toggle" onclick="toggleDropdown()"
								aria-expanded="false">
								<div style="display: flex; align-items: center;">
									<img class="userlogo" src="/imageresources/user.png"
										alt="User Logo">
									<div style="margin-left: 8px;"><%=loggedInUser%>
										▼
									</div>
								</div>
							</button>
							<div id="dropdown-menu" class="dropdown-menu">
								<a href="#" class="logout-link" onclick="handleLogout()"
									title="Sign Out">Sign Out</a>
							</div>
						</div>
						<%
						}
						%>
					</div>

				</div>
			</nav>
		</header>
	</div>

	<h1>Search Flights</h1>

	<!-- <div class="search-container">
		<form id="flightSearchForm">
			<div class="form-grid">
				<div class="form-group">
					<div class="label-container">
						<label for="source">Source</label>
					</div>
					<div class="input-container">
						<input type="text" id="source" name="source"
							placeholder="Enter Source" autocomplete="on" />
					</div>
					<div class="suggestions" id="sourceSuggestions"></div>
				</div>
				<div class="form-group">
					<div class="label-container">
						<label for="destination">Destination</label>
					</div>
					<div class="input-container">
						<input type="text" id="destination" name="destination"
							placeholder="Enter Destination" autocomplete="on" />
					</div>
					<div class="suggestions" id="destinationSuggestions"></div>
				</div>
				<div class="form-group-btn">
					<button class="submit-btn" type="submit">Search</button>
				</div>
			</div>
		</form>
		<div id="statusMessage" class="error-message"></div>
	</div> -->
	
	<div class="search-container">
            <form id="flightSearchForm">
                <div class="form-grid">
                    <div class="form-group">
                        <div class="label-container"><label for="source">Source</label></div>
                        <div class="input-container"><input type="text" id="source" name="source" placeholder="Enter Source" value="${not empty source ? source : ''}" autocomplete="off" required/></div>
                        <div class="suggestions" id="sourceSuggestions"></div>
                    </div>
                    <div class="form-group">
                        <div class="label-container"><label for="destination">Destination</label></div>
                        <div class="input-container"><input type="text" id="destination" name="destination" placeholder="Enter Destination" value="${not empty destination ? destination : ''}" autocomplete="off" required/></div>
                        <div class="suggestions" id="destinationSuggestions"></div>
                    </div>
                    <div class="form-group-btn">
                        <button class="submit-btn" type="submit">Search</button>
                    </div>
                </div>
            </form>
            <div id="statusMessage" class="error-message"></div>
        </div>


	<div class="table-container" id="table-container"
		style="display: none;">
		<div class="body-head-titles">
			<a href="#" class="back-button">← Back </a>
			<h2 id="flight-details-title" class="flight-details-title">Flight
				Details</h2>
			<div style="width: 120px;"></div>
		</div>

		<div id="flight-card-container" class="flight-card-container"></div>
	</div>



	<script>
	
	    document.addEventListener("click", function (event) {
	    	const toggleButton = document.querySelector(".dropdown-toggle");
	        const dropdownMenu = document.getElementById("dropdown-menu");
	        const logoutLink = document.getElementById("logout-link");
	        
	 
	        if (logoutLink && !logoutLink.contains(event.target) && dropdownMenu.classList.contains("show")) {
	            logoutLink.style.display = "none";
	            dropdownMenu.classList.remove("show");
	        }
	    });
	 
    </script>

	<script>
	// Check if JWT exists in localStorage
	const token = localStorage.getItem("jwt");

if (token) {
  fetch("/sourceAndDestination", {
    method: "GET",
    headers: {
      "Authorization": "Bearer " + token
    }
  })
  .then(res => res.text())
  .then(html => {
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, "text/html");
    const newLoginSection = doc.getElementById("loginSection");

    if (newLoginSection) {
      document.getElementById("loginSection").innerHTML = newLoginSection.innerHTML;

      // Rebind toggleDropdown
      window.toggleDropdown = function () {
        const menu = document.getElementById("dropdown-menu");
        if (menu) {
          menu.classList.toggle("show");
        }
      };
    }
  })
  .catch(err => {
    console.error("Failed to update login section:", err);
  });
}


       	  
		document.getElementById("flightSearchForm").addEventListener("submit", function (e) {
		    e.preventDefault();
		
		    const source = document.getElementById("source").value.trim();
		    const destination = document.getElementById("destination").value.trim();
		    const statusDiv = document.getElementById("statusMessage");
		    const flightTableContainer = document.getElementById("flight-card-container");
		    const tableContainer = document.getElementById("table-container");
		    
		    if (!source && !destination) {
		        e.preventDefault(); // Stop form submission
		        statusDiv.innerHTML = `<div style="color: red;">Please enter at least a source or a destination.</div>`;
		    }
		
		    statusDiv.innerHTML = "";
		    flightTableContainer.innerHTML = "";
		
		    fetch("sourceAndDestinationapi/sourceAndDestination", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded"
		        },
		        body: new URLSearchParams({ source, destination })
		    })
		    .then(response => {
		        if (response.status === 410) {
		        	tableContainer.style.display = "none";
		            throw new Error("Please enter either the source or destination.");
		        } else if(response.status === 204){
		        	tableContainer.style.display = "none";
		        	throw new Error("No flights are available from these source and destination.");
		        } else if (!response.ok) {
		            throw new Error("Server error occurred.");
		        } 
		        return response.json();
		    })
		    .then(flights => {
					
		    	console.log(flights);
		    	
		        // Show table only if data exists
		        tableContainer.style.display = "block";
		        
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
	                                <button class="book-button" onclick="submitFlight('\${flightIdStr}')">BOOK</button>
	                            </div>
	                        </div>
	                  	</div>
					`;
                    flightTableContainer.innerHTML += cardHtml;
                });
		
		        
		    })
		    .catch(error => {
		    	console.log(error);
		        statusDiv.innerHTML = error.message;
		    });
		});
		
		function submitFlight(id) {
			const form = document.createElement('form');
			form.method = 'POST';
			form.action = 'sdticket';
	
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
	            themeLink.setAttribute('href', '/sourceanddestinationcss/sourceanddestinationdark.css');
	            lightIcon.style.display = 'none';
	            darkIcon.style.display = 'inline';
	        } else {
	            themeLink.setAttribute('href', '/sourceanddestinationcss/sourceanddestinationlight.css');
	            lightIcon.style.display = 'inline';
	            darkIcon.style.display = 'none';
	        }
	    });


	
     function toggleDarkMode() {
   	    const themeLink = document.getElementById('theme-link');
   	    const button = document.getElementById('theme-toggle');
   	    const lightIcon = document.querySelector('.light-icon');
   	    const darkIcon = document.querySelector('.dark-icon');
   	    const currentTheme = themeLink.getAttribute('href');

   	    const lightTheme = '/sourceanddestinationcss/sourceanddestinationlight.css';
   	    const darkTheme = '/sourceanddestinationcss/sourceanddestinationdark.css';

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

     
     
     
     
        
    	
    	
		
   	    function handleLogout() {
   	        localStorage.removeItem("jwt");
   	        window.location.href = window.location.origin.replace(/:\d+/, ":3336") + "/logout";
   	    }
    	

		function toggleDropdown() {
			const menu = document.getElementById("dropdown-menu");
			menu.classList.toggle("show");
		}
	
		// Optional: Close dropdown if clicked outside
		window.onclick = function(event) {
			if (!event.target.matches('.dropdown-toggle')) {
				const dropdowns = document.getElementsByClassName("dropdown-menu");
				for (let i = 0; i < dropdowns.length; i++) {
					dropdowns[i].classList.remove('show');
				}
			}
		};
		window.addEventListener("load", () => {
			  const resultsSection = document.getElementById("results");
			  if (resultsSection) {
			    resultsSection.scrollIntoView({ behavior: "smooth" });
			  }
			});
		
		 //Suggestions
		function setupAutocomplete(inputId, suggestionsId, apiUrl) {
		    const input = document.getElementById(inputId);
		    const suggestions = document.getElementById(suggestionsId);
		
		    input.addEventListener("input", () => {
		        const value = input.value.toLowerCase();
		        suggestions.innerHTML = "";
		
		        if (value) {
		            fetch(apiUrl + "?query=" + encodeURIComponent(value))
		                .then(response => response.json())
		                .then(dataList => {
		                    dataList.forEach(item => {
		                        const div = document.createElement("div");
		                        div.textContent = item;
		                        div.onclick = () => {
		                            input.value = item;
		                            suggestions.innerHTML = "";
		                        };
		                        suggestions.appendChild(div);
		                    });
		                })
		                .catch(error => console.error("Autocomplete fetch error:", error));
		        }
		    });
		
		    document.addEventListener("click", (e) => {
		        if (!suggestions.contains(e.target) && e.target !== input) {
		            suggestions.innerHTML = "";
		        }
		    });
		}
		
		setupAutocomplete("source", "sourceSuggestions", "/api/sources");
		setupAutocomplete("destination", "destinationSuggestions", "/api/destinations"); 
		 
		
		
	</script>

</body>
</html>