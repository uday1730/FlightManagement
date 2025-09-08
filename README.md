✈️ Flight Management System
A comprehensive Flight Management System built using Spring Boot MVC and a microservices architecture. It enables users to view, search, and plan flights with robust backend services and a clean frontend interface.

🚀 Features
View All Flights: Browse a complete list of available flights.

Plan a Trip: Select flights and destinations to organize your travel.

Search by Destination: Find flights arriving at a specific city.

Search by Source: Locate flights departing from a chosen city.

Manage Flight Data: Add, update, or delete flight information via backend services.

🛠️ Technologies Used
🔹 Frontend
HTML5 – Structure and layout of web pages

CSS3 – Styling and responsive design

JavaScript – Dynamic behavior and interactivity

JSP (JavaServer Pages) – View layer for rendering backend data

🔹 Backend
Spring Boot – Core framework for rapid development

Spring MVC – Handles HTTP requests and responses

Microservices Architecture – Modular services for scalability

Eureka Server – Service registry for discovery

API Gateway – Centralized routing and filtering

REST APIs – Communication between frontend and backend

Maven – Dependency and build management

ORM (JPA + Hibernate) – Data persistence and mapping

🔹 Database
Relational Database – Stores flight and trip data

JPA + Hibernate – ORM layer for seamless data access

⚙️ Setup Instructions
1. Clone the Repository
bash
git clone [your-repository-url]
2. Configure the Database
Update the application.properties file in each microservice with your database credentials.

3. Run the Services
Start the services in the following order:

text
1. Eureka Server
2. API Gateway
3. Individual Microservices
4. Access the Application
Open your browser and navigate to:

text
http://localhost:[port]
Replace [port] with the configured port for your API Gateway.
