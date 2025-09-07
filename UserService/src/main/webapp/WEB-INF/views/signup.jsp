<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
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
    String cssPath = theme.equals("dark") ? "/userservicecss/signupdark.css" : "/userservicecss/signuplight.css";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta name="description" content="Flight Management System main page with theme support" />
    <title>SignUp Page</title>

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
				<a href="/Userlogin" class="pill" title="Login">👤 Login</a>
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

    <div class="login-container">
        <h2>Welcome New User</h2>
        <form action="UsersignUp" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"
                       placeholder="Enter your username"
                       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" />
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" />
            </div>
            <div class="form-group">
                <label for="passwordcheck">Re-Enter Password</label>
                <input type="password" id="passwordcheck" name="passwordcheck" placeholder="Re-Enter your password" />
            </div>
            	<div class="form-group">
					<label for="checkadminuser">SignUp Type</label> <select
						id="checkadminuser" name="checkadminuser" required>
						<option value="user">User</option>
						<option value="admin">Admin</option>
					</select>
				</div>
            <button class="login-btn" type="submit">Sign Up</button>
        </form>

        <!-- 👇 Dynamic error message -->
       <div class="footer">
			<c:if test="${not empty sessionScope.error}">
				<p style="color: red">${sessionScope.error}</p>
				<%
				session.removeAttribute("error");
				%>
			</c:if>

			<c:if test="${not empty sessionScope.loggedout}">
				<p style="color: green">${sessionScope.loggedout}</p>
				<%
				session.removeAttribute("loggedout");
				%>
			</c:if>

		</div>
    </div>

    <script>

	 // Apply saved theme on page load
   window.addEventListener('load', () => {
       const savedTheme = localStorage.getItem('theme');
       const themeLink = document.getElementById('theme-link');
       const lightIcon = document.querySelector('.light-icon');
       const darkIcon = document.querySelector('.dark-icon');

       if (savedTheme === 'dark') {
           themeLink.setAttribute('href', '/userservicecss/signupdark.css');
           lightIcon.style.display = 'none';
           darkIcon.style.display = 'inline';
       } else {
           themeLink.setAttribute('href', '/userservicecss/signuplight.css');
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

	    const lightTheme = '/userservicecss/signuplight.css';
	    const darkTheme = '/userservicecss/signupdark.css';

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
</body>
</html>
