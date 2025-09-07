<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    String cssPath = theme.equals("dark") ? "/mainpagecss/mainpagedark.css" : "/mainpagecss/mainpagelight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="description" content="Flight Management System main page with theme support" />
    <title>Flight Management System</title>

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

	<main class="container">
		<section class="content">
			<section class="hero">
				<h1>Welcome to the Flight Management System</h1>
			</section>

			<section class="features-section">
				<h2>Application Features</h2>
				<div class="features-grid" style="padding: 0 40px;">

					<a class="feature-card"
						onclick="window.location.href='/allFlightInfo';">
						<div class="feature-icon">
							<img class="features-icons"
								src="/imageresources/view_all_flights_icon.png" alt="User Logo">
						</div>
						<div class="feature-title-div">
							<text class="feature-title">View All Flight Information</text>
						</div>
						<div class="feature-description">
							<p>List every flight with full details and statuses.</p>
						</div>
					</a> 
					
					<a class="feature-card"
						onclick="window.location.href='/sourceAndDestination';">
						<div class="feature-icon">
							<img class="features-icons"
								src="/imageresources/search_flight_icon.png" alt="User Logo">
						</div>
						<div class="feature-title-div">
							<text class="feature-title">Search by Source/Destination</text>
						</div>
						<div class="feature-description">
							<p>Find flights departing from a given source city or
								airport.</p>
						</div>
					</a> 
					<a class="feature-card" onclick="window.location.href='/plan';">
						<div class="feature-icon">
							<img class="features-icons"
								src="/imageresources/search_by_source_destination_icon.png"
								alt="User Logo">
						</div>
						<div class="feature-title-div">
							<text class="feature-title">Plan Journey</text>
						</div>
						<div class="feature-description">
							<p>Filter flights by type (e.g., commercial, cargo, private).</p>
						</div>
					</a>
					<a class="feature-card"
						onclick="${isAdmin eq true ? 'window.location.href=\'/addFlight\'' : 'showAccessDeniedPopup()'}">
						<div class="feature-icon">
							<img class="features-icons"
								src="/imageresources/add_flight_icon.png" alt="Add Flight">
						</div>
						<div class="feature-title-div">
							<text class="feature-title">Add New Flight</text>
						</div>
						<div class="feature-description">
							<p>${isAdmin eq true 
                ? 'Create a new flight record with schedule and plane details.' 
                : '<strong>Admin access required</strong> to create a new flight record.'}
							</p>
						</div>
					</a> 
					<a class="feature-card"
						onclick="${isAdmin eq true ? 'window.location.href=\'/updateFlight\'' : 'showAccessDeniedPopup()'}">
						<div class="feature-icon">
							<img class="features-icons"
								src="/imageresources/update_flight_icon.png" alt="User Logo">
						</div>
						<div class="feature-title-div">
						<text class="feature-title">Update Flight Details</text>
						</div>
						<div class="feature-description">
							<p>${isAdmin eq true 
                ? 'Edit schedule, aircraft or crew details of an existing
								flight.' 
                : '<strong>Admin access required</strong> to update a flight record.'}
							</p>
						</div>
					</a>
					<a class="feature-card"
						onclick="${isAdmin eq true ? 'window.location.href=\'/deleteFlight\'' : 'showAccessDeniedPopup()'}">
						<div class="feature-icon">
							<img class="features-icons"
								src="/imageresources/add_flight_icon.png" alt="Add Flight">
						</div>
						<div class="feature-title-div">
							<text class="feature-title">Delete Flight Record</text>
						</div>
						<div class="feature-description">
							<p>${isAdmin eq true 
                ? 'Remove a flight from the system when it’s no longer valid.' 
                : '<strong>Admin access required</strong> to delete a flight record.'}
							</p>
						</div>
					</a>
				</div>
			</section>

		</section>
	</main>

	<footer class="site-footer">
		<small>© 2025 Flight Management System</small>
	</footer>

	<script>
	
	
	
	
	
	function showAccessDeniedPopup() {
	    alert("Access denied: only admin users can access this service.");
	}

    // Apply saved theme on page load
    window.addEventListener('load', () => {
        const savedTheme = localStorage.getItem('theme');
        const themeLink = document.getElementById('theme-link');
        const lightIcon = document.querySelector('.light-icon');
        const darkIcon = document.querySelector('.dark-icon');

        if (savedTheme === 'dark') {
            themeLink.setAttribute('href', '/mainpagecss/mainpagedark.css');
            lightIcon.style.display = 'none';
            darkIcon.style.display = 'inline';
        } else {
            themeLink.setAttribute('href', '/mainpagecss/mainpagelight.css');
            lightIcon.style.display = 'inline';
            darkIcon.style.display = 'none';
        }
    });

    // Theme toggle function
    function toggleDarkMode() {
        const themeLink = document.getElementById('theme-link');
        const button = document.getElementById('theme-toggle');
        const lightIcon = document.querySelector('.light-icon');
        const darkIcon = document.querySelector('.dark-icon');

        const lightTheme = '/mainpagecss/mainpagelight.css';
        const darkTheme = '/mainpagecss/mainpagedark.css';

        if (themeLink.getAttribute('href') === lightTheme) {
            themeLink.setAttribute('href', darkTheme);
            lightIcon.style.display = 'none';
            darkIcon.style.display = 'inline';
            localStorage.setItem('theme', 'dark');
        } else {
            themeLink.setAttribute('href', lightTheme);
            lightIcon.style.display = 'inline';
            darkIcon.style.display = 'none';
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
    

	  // Check if JWT exists in localStorage
	  const token = localStorage.getItem("jwt");

	  if (token) {
	    fetch("/homePage", {
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
	

    
</script>

</body>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const theme = localStorage.getItem("theme") || "light";
    const lightIcon = document.querySelector(".light-icon");
    const darkIcon = document.querySelector(".dark-icon");

    if (theme === "dark") {
      if (lightIcon) lightIcon.style.display = "none";
      if (darkIcon) darkIcon.style.display = "inline";
    } else {
      if (lightIcon) lightIcon.style.display = "inline";
      if (darkIcon) darkIcon.style.display = "none";
    }
  });
</script>

</html>
