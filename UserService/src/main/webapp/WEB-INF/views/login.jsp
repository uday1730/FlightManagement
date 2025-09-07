<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="true"%>
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
    String cssPath = theme.equals("dark") ? "/userservicecss/userlogindark.css" : "/userservicecss/userloginlight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="description" content="Flight Management System main page with theme support" />
    <title>Login Page</title>

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
				<img class="logo" src="/userservicecss/airplane-mode.png"
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
				<a href="#settings" class="pill hover-pill" title="My Bookings">My
					Bookings</a>
				<%
				String loggedInUser = (String) session.getAttribute("loggedInUser");
				if (loggedInUser == null) {
				%>
				<a href="/Userlogin" class="pill" title="Login"> Login</a>
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
						<a href="#" class="pill" onclick="handleLogout()" title="Sign Out">Sign
							Out</a>
					</div>
				</div>
				<%
				}
				%>


			</div>
		</nav>
	</header>

	<div class="login-page-content">
		<h2 class="welcome-text">Welcome Back</h2>
		<div class="login-container">
			<form id="loginForm">
				<div class="form-grid">
					<div class="form-group-item">
						<label for="username">Username</label> <input type="text"
							id="username" name="username" required
							value="<%=request.getParameter("username") != null ? request.getParameter("username") : ""%>" />
					</div>
					<div class="form-group-item">
						<label for="password">Password</label> <input type="password"
							id="password" name="password" required />
					</div>
					<div class="form-group-item">
						<label for="checkadminuser">Login Type</label> <select
							id="checkadminuser" name="checkadminuser" required>
							<option value="user">User</option>
							<option value="admin">Admin</option>
						</select>
					</div>

					<div class="form-group-item">
						<button class="login-btn" type="submit">Login</button>
					</div>
				</div>
			</form>
			<div id="error" class="error-message">
				<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
			</div>
			
			
			
						<%
				String error = request.getParameter("ticketerror");
				%>
				<%
				if (error != null) {
				%>
				<div class="error-message"><%=error%></div>
				<%
				}
				%>

			<!-- 👇 Sign-Up Prompt for New Users -->
			<div class="signup-prompt"
				style="margin-top: 20px; text-align: center;">
				<text style="color: #007bff;">
					New user? <a href="UsersignUp"
						style="color: #007bff; text-decoration: underline;">Create an
						account</text>
				</p>
			</div>
		</div>
	</div>


	<script>
        document.addEventListener("DOMContentLoaded", function () {
            const toggleButton = document.querySelector(".dropdown-toggle");
            const dropdownMenu = document.getElementById("logout-link");

            toggleButton.addEventListener("click", function () {
                dropdownMenu.classList.toggle("show");
            });

            document.addEventListener("click", function (event) {
                if (!toggleButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
                    dropdownMenu.classList.remove("show");
                }
            });
        });
        
        
        
        
        
        document.getElementById("loginForm").addEventListener("submit", function(e) {
            e.preventDefault();

            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;
            const loginType = document.getElementById("checkadminuser").value;
            const checkadminuser = loginType === "admin" ? "admin" : "user";


            fetch("/Userlogin", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({
                    username,
                    password,
                    checkadminuser 
                })


            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Invalid credentials");
                }
                return response.json();
            })
            .then(data => {
                // Store JWT in localStorage
                localStorage.setItem("jwt", data.token);

                // Redirect to homePage
                window.location.href = "/homePage";
            })
            .catch(error => {
                document.getElementById("error").textContent = "Login failed. Please try again.";
            });
        });

        
        
        


		 // Apply saved theme on page load
	    window.addEventListener('load', () => {
	        const savedTheme = localStorage.getItem('theme');
	        const themeLink = document.getElementById('theme-link');
	        const lightIcon = document.querySelector('.light-icon');
	        const darkIcon = document.querySelector('.dark-icon');

	        if (savedTheme === 'dark') {
	            themeLink.setAttribute('href', '/userservicecss/userlogindark.css');
	            lightIcon.style.display = 'none';
	            darkIcon.style.display = 'inline';
	        } else {
	            themeLink.setAttribute('href', '/userservicecss/userloginlight.css');
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

   	    const lightTheme = '/userservicecss/userloginlight.css';
   	    const darkTheme = '/userservicecss/userlogindark.css';

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
    </script>
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
</body>
</html>
