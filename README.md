# FlightManagementSystem
 
This is a comprehensive Flight Management System developed using the Spring Boot MVC framework. The application provides various functionalities for managing flights, including viewing, searching, and planning trips. The project is built with a microservices architecture, leveraging Eureka Server for service discovery and an API Gateway for routing requests.
 
Features
 
View All Flights: Browse a complete list of all available flights.
Plan a Trip: Users can plan their trip by selecting flights and destinations.
Search Flights by Destination: Find flights based on the arrival city.
Search Flights by Source: Locate flights departing from a specific city.
Manage Flight Data: Back-end services to handle flight information, including additions, modifications, and deletions.
 
Technologies Used
 
 
Frontend
 
HTML5: The markup language for structuring the web pages.
CSS3: Used for styling and layout of the user interface.
JavaScript: Provides interactive elements and dynamic behavior.
JSP (JavaServer Pages): Used as the view layer to render dynamic content from the backend.
 
Backend
 
Spring Boot: The core framework for building the application, simplifying configuration and deployment.
Spring MVC: The model-view-controller framework for handling web requests.
Microservices Architecture: The application is broken down into smaller, independent services for better scalability and maintainability.
Eureka Server: A service registry for discovering and locating microservices.
API Gateway: A single entry point for all client requests, routing them to the appropriate microservice.
REST APIs: Used for communication between the frontend and the backend services.
Maven: The build automation tool for managing project dependencies.
ORM (Object-Relational Mapping): A technique for converting data between incompatible type systems using object-oriented programming languages.
JPA (Java Persistence API): The standard specification for ORM in Java.
Hibernate: The most popular JPA implementation used for data persistence.
 
Database
 
The project uses a relational database to store flight data. ORM, JPA, and Hibernate are used to facilitate easy data access and manipulation.
 
Setup Instructions
 
Clone the Repository:
Bash
 
Plain Text
git clone [your-repository-url]


Configure the Database:
Update the database connection properties in application.properties for each microservice.
Run the Services:
Start the Eureka Server first.
Then, start the API Gateway.
Finally, start the individual microservices.
Access the Application:
Open your web browser and navigate to http://localhost:[port] (where [port] is the port configured for your API Gateway).
 
Project Structure
 
The project follows a standard microservices layout, with each service having its own directory.
eureka-server/: The service registry.
api-gateway/: The routing and filtering layer.
flight-service/: Manages flight data.
trip-planning-service/: Handles trip-related logic.
... (other microservices)
