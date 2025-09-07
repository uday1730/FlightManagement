<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		? "/userplancss/userplandark.css"
		: "/userplancss/userplanlight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<meta name="description"
	content="Flight Management System main page with theme support" />
<title>Plan Flight</title>

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

	<header class="site-header">
		<nav class="navbar">
			<div class="nav-left" onclick="window.location.href='/homePage';">
				<img class="logo" src="/userplancss/airplane-mode.png"
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


	<h1>Search Flights</h1>

        <div class="search-container">
            <form id="flightSearchForm" method="post" action="plan">
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
                    <div class="form-group">
                        <div class="label-container"><label for="fare">Fare</label></div>
                        <div class="input-container"><input type="number" min=1 id="fare" name="fare" placeholder="Enter Fare" value="${fare > 0 ? fare : ''}"  autocomplete="off" required/></div>
                        <div class="suggestions" id="destinationSuggestions"></div>
                    </div>
                    <div class="form-group-btn">
                        <button class="submit-btn" type="submit">Search</button>
                    </div>
                </div>
            </form>
            <div id="statusMessage" class="error-message"></div>
        </div>


		<div class="footer">
			<c:if test="${not empty success}">
				<p style="color: green">${success}</p>
			</c:if>
			<c:if test="${not empty error}">
				<p style="color: red">${error}</p>
			</c:if>
		</div>


			<c:if test="${submitted}">
					<c:if test="${not empty planflights}">
					    <div class="table-container" id="table-container">
					        <div class="body-head-titles">
					            <a href="#" class="back-button">← Back </a>
					            <h2 id="flight-details-title" class="flight-details-title">Flight Details</h2>
					            <div style="width: 120px;"></div>
					        </div>
					
					        <div id="flight-card-container" class="flight-card-container">
					            <c:forEach var="flight" items="${planflights}">
					                <c:set var="logoUrl" value=""/>
					                <c:choose>
					                    <c:when test="${flight.name eq 'Air India'}">
					                        <c:set var="logoUrl" value="https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/AI.png?v=20"/>
					                    </c:when>
					                    <c:when test="${flight.name eq 'SpiceJet'}">
					                        <c:set var="logoUrl" value="https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/SG.png?v=20"/>
					                    </c:when>
					                    <c:when test="${flight.name eq 'IndiGo'}">
					                        <c:set var="logoUrl" value="https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/6E.png?v=20"/>
					                    </c:when>
					                    <c:when test="${flight.name eq 'Akasa Air'}">
					                        <c:set var="logoUrl" value="https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/QP.png?v=20"/>
					                    </c:when>
					                    <c:otherwise>
					                        <c:set var="logoUrl" value="https://imgak.mmtcdn.com/flights/assets/media/dt/common/icons/6E.png?v=20"/>
					                    </c:otherwise>
					                </c:choose>
					                
						                <div class="flight-card">
						                    <div class="flight-info-left">
						                        <div class="airline-details">
						                            <div class="airline-logo"
						                                style="background-image: url('${logoUrl}');"></div>
						                            <div class="date-id-name-div">
						                                <p class="journey-date">${flight.date}</p>
						                                <p class="airline-name">${flight.name}</p>
						                                <p class="flight-id">${flight.id}</p>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="flight-info-middle">
						                        <div class="timing-details">
						                            <div class="time-city">
						                                <h3>${flight.departure}</h3>
						                                <p>${flight.source}</p>
						                            </div>
						                            <div class="flight-divider">
						                                <span class="duration-text">${fn:split(flight.duration, ':')[0]} h ${fn:split(flight.duration, ':')[1]} m</span>
						                                <hr class="flight-line">
						                                <span class="flight-label">${flight.type}</span>
						                            </div>
						                            <div class="time-city">
						                                <h3>${flight.arrival}</h3>
						                                <p>${flight.destination}</p>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="flight-info-right">
						                        <div class="price-and-book">
						                            <span class="price-display">₹ <fmt:formatNumber value="${flight.fare}" type="number" groupingUsed="true"/></span>
						                            <button class="book-button" onclick="submitFlight('${flight.id}')">BOOK</button>
						                        </div>
						                    </div>
						                </div>
					            </c:forEach>
					        </div>
					    </div>
			</c:if>

			<c:if test="${empty planflights}">
				<p class="no-results">No flights found for the given route.</p>
			</c:if>

	</c:if>

	<script>
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
	
	<script>
		function submitFlight(id) {
			const form = document.createElement('form');
			form.method = 'POST';
			form.action = 'plticket';
	
			const input = document.createElement('input');
			input.type = 'hidden';
			input.name = 'id';
			input.value = id;
	
			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();
		}
	
	 function handleLogout() {
	        localStorage.removeItem("jwt");
	        window.location.href = window.location.origin.replace(/:\d+/, ":3336") + "/logout";
	    }
	 
	 
	 
	 
		// Check if JWT exists in localStorage
		const token = localStorage.getItem("jwt");

		if (token) {
		  fetch("/plan", {
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

	 
	 
	 
	 
	    
	 // Theme toggle function
	   
		 // Apply saved theme on page load
	    window.addEventListener('load', () => {
	        const savedTheme = localStorage.getItem('theme');
	        const themeLink = document.getElementById('theme-link');
	        const lightIcon = document.querySelector('.light-icon');
	        const darkIcon = document.querySelector('.dark-icon');

	        if (savedTheme === 'dark') {
	            themeLink.setAttribute('href', '/userplancss/userplandark.css');
	            lightIcon.style.display = 'none';
	            darkIcon.style.display = 'inline';
	        } else {
	            themeLink.setAttribute('href', '/userplancss/userplanlight.css');
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

   	    const lightTheme = '/userplancss/userplanlight.css';
   	    const darkTheme = '/userplancss/userplandark.css';

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
	 
	</script>

</body>
</html>
