<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Submission Status</title>
    <script>
        alert("${message}");
        window.location.href = "allFlights"; // Redirect after alert
    </script>
</head>
<body>
    <h2>${message}</h2>
</body>
</html>