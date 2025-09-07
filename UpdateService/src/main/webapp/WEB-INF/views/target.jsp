<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Flight Entry Form</title>

<style>
body {
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
	background-color: rgb(25, 26, 25);
	color: #ffffff;
	display: flex;
	flex-direction: column;
	align-items: center;
	min-height: 100vh;
	scroll-behavior: smooth;
}

.site-header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background-color: rgb(25, 26, 25);
	z-index: 1000;
}

.navbar {
	max-width: 1200px;
	margin: 0 auto;
	padding: 18px 20px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.nav-left, .nav-right {
	display: flex;
	align-items: center;
	gap: 12px;
}

.logo {
	width: 36px;
	height: 36px;
	border-radius: 6px;
}

.site-title .brand {
	font-weight: 700;
	font-size: 1.1rem;
}

.site-title .sub {
	font-size: 0.8rem;
	color: #98a0ad;
}

.nav-center {
	flex: 1;
	display: flex;
	justify-content: center;
}

.home-pill {
	background: #56c056;
	border: 1px solid rgb(238, 238, 238);
	color: black;
	padding: 8px 14px;
	border-radius: 999px;
	text-decoration: none;
	font-weight: 600;
	box-shadow: 0 6px 18px rgba(221, 224, 219, 0.1);
}

.home-pill:hover {
	transform: translateY(-4px);
	box-shadow: 0 14px 32px rgba(109, 179, 63, 0.2);
}

.pill {
	background: rgba(255, 255, 255, 0.1);
	border: none;
	color: #eafaf9;
	padding: 10px 14px;
	border-radius: 999px;
	cursor: pointer;
	font-weight: 600;
	box-shadow: 0 6px 14px rgba(0, 0, 0, 0.35);
	text-decoration: none;
}

.pill:hover {
	transform: translateY(-6px) scale(1.02);
	box-shadow: 0 18px 40px rgba(0, 0, 0, 0.6);
}

.sourcedestination-container {
	background-color: #2f2f2f;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 0 14px rgba(86, 192, 86, 0.18);
	width: 80%;
	max-width: 800px;
	margin-top: 120px;
	margin-bottom: 40px;
}

.sourcedestination-container h2 {
	text-align: center;
	margin-bottom: 30px;
	margin-top: -10px;
	font-size: 24px;
	color: #56c056;
}

form {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-between;
}

.form-row {
	width: 46%;
}

.form-row {
	display: flex;
	align-items: center;
	gap: 10px;
	width: 48%;
}

.form-row label {
	min-width: 120px;
	font-size: 14px;
	font-weight: bold;
	color: #eafaf9;
}

.form-row input {
	flex: none;
	width: 220px;
	padding: 8px;
	border: none;
	border-radius: 6px;
	background-color: #1e1e1e;
	color: #fff;
}

.form-row input:focus {
	outline: 2px solid #56c056;
}

.submit-btn {
	width: 300px;
	padding: 12px;
	background-color: #4caf50;
	border: none;
	border-radius: 6px;
	color: #fff;
	font-weight: bold;
	cursor: pointer;
	margin: 20px auto 0 auto;
	display: block;
}

.footer {
	margin-top: 20px;
	text-align: center;
	font-size: 12px;
	color: #aaa;
}

.footer a {
	color: #56c056;
	text-decoration: none;
}

.footer a:hover {
	text-decoration: underline;
}

.form-row label {
	min-width: 120px;
	font-size: 14px;
	font-weight: bold; /* 👈 This makes the label text bold */
	color: #eafaf9; /* Optional: ensures high contrast */
}

@media ( max-width : 768px) {
	.form-row {
		width: 100%;
		flex-direction: column;
		align-items: flex-start;
	}
	.form-row label {
		margin-bottom: 6px;
	}
	.submit-btn:hover {
		background-color: #45a049;
		transform: scale(1.05);
		box-shadow: 0 8px 20px rgba(76, 175, 80, 0.3);
	}
}
</style>

</head>
<body>
	<header class="site-header">
		<nav class="navbar">
			<div class="nav-left">
				<svg class="logo" viewBox="0 0 48 48" width="36" height="36">
                <circle cx="24" cy="24" r="22" fill="#32cd32" />
                <path d="M14 30c6 0 10-9 14-14 0 0-4 1-8 1s-11 7-6 13z"
						fill="#fff" opacity="0.95" />
            </svg>
				<div class="site-title">
					<div class="brand">Flight Management</div>
					<div class="sub">System</div>
				</div>
			</div>
			<div class="nav-center">
				<a class="home-pill" href="/homePage">Home</a>
			</div>
			<div class="nav-right">
				<a href="#create" class="pill">➕ Create</a> <a href="#settings"
					class="pill">⚙️ Settings</a>
				<%
				String loggedInUser = (String) session.getAttribute("loggedInUser");
				if (loggedInUser == null) {
				%>
				<!-- <a href="/userinfo/Userlogin" class="pill">📊 Login</a> -->
				<a href="/userinfo/Userlogin" class="pill"> <svg
						xmlns="http://www.w3.org/2000/svg" width="18" height="18"
						fill="#eafaf9" viewBox="0 0 24 24"
						style="vertical-align: middle; margin-right: 6px;">
    <path
							d="M12 12c2.7 0 5-2.3 5-5s-2.3-5-5-5-5 2.3-5 5 2.3 5 5 5zm0 2c-3.3 0-10 1.7-10 5v3h20v-3c0-3.3-6.7-5-10-5z" />
  </svg> Login
				</a>
				<%
				} else {
				%>
				<div class="dropdown">
					<button class="pill dropdown-toggle" onclick="toggleDropdown()">
						👤
						<%=loggedInUser%>
						▼
					</button>
					<div id="dropdown-menu" class="dropdown-menu">
						<a href="/userinfo/logout" class="pill">Sign Out</a>
	 					</div>
				</div>
				<%
				}
				%>
			</div>
		</nav>
	</header>

	<div class="sourcedestination-container">
    <h2>Enter Flight Details</h2>
    <form action="submitFlight" method="get">
        <div class="form-row">
	            <label for="id">Flight ID:</label>
	            <input type="number" id="id" name="id"
	                value="${flightObj != null && flightObj.id > 0 ? flightObj.id : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="name">Flight Name:</label>
	            <input type="text" id="name" name="name"
	                value="${flightObj != null && flightObj.name != null ? flightObj.name : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="source">Source:</label>
	            <input type="text" id="source" name="source"
	                value="${flightObj != null && flightObj.source != null ? flightObj.source : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="destination">Destination:</label>
	            <input type="text" id="destination" name="destination"
	                value="${flightObj != null && flightObj.destination != null ? flightObj.destination : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="type">Type:</label>
	            <input type="text" id="type" name="type"
	                value="${flightObj != null && flightObj.type != null ? flightObj.type : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="fare">Fare:</label>
	            <input type="number" id="fare" name="fare"
	                value="${flightObj != null && flightObj.fare != 0 ? flightObj.fare : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="date">Date:</label>
	            <input type="date" id="date" name="date"
	                value="${flightObj != null && flightObj.date != null ? flightObj.date : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="departure">Departure Time:</label>
	            <input type="time" id="departure" name="departure"
	                value="${flightObj != null && flightObj.departure != null ? flightObj.departure : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="arrival">Arrival Time:</label>
	            <input type="time" id="arrival" name="arrival"
	                value="${flightObj != null && flightObj.arrival != null ? flightObj.arrival : ''}" required />
	        </div>
	
	        <div class="form-row">
	            <label for="duration">Duration:</label>
	            <input type="time" id="duration" name="duration"
	                value="${flightObj != null && flightObj.duration != null ? flightObj.duration : ''}" />
	        </div>
	
	
			<input type="hidden" name="oldId" value="${flightObj != null ? flightObj.id : ''}" />
			
	        <button class="submit-btn" type="submit">Submit Flight</button>
	    </form>
	</div>

	<script>
		function toggleDropdown() {
			const menu = document.getElementById("dropdown-menu");
			menu.classList.toggle("show");
		}

		window.onclick = function(event) {
			if (!event.target.matches('.dropdown-toggle')) {
				const dropdowns = document
						.getElementsByClassName("dropdown-menu");
				for (let i = 0; i < dropdowns.length; i++) {
					dropdowns[i].classList.remove('show');
				}
			}
		};
	</script>

</body>
</html>
