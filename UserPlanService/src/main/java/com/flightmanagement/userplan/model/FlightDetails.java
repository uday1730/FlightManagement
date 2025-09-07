package com.flightmanagement.userplan.model;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
 
@Entity
@Table(name = "flight_info")
@Component
public class FlightDetails {
 
	@Id
	@Column(name="Flight_Id")
	private int id;
	@Column(name="Flight_Name")
	private String name;
	@Column(name="Source_City")
	private String source;
	@Column(name="Destination_City")
	private String destination;
	@Column(name="Flight_Type")
	private String type;
	@Column(name="Fare")
	private int fare;
	@Column(name="Date_Of_Journey")
	private LocalDate date;
	@Column(name="Departure_Time")
	private LocalTime departure;
	@Column(name="Arrival_Time")
	private LocalTime arrival;
	@Column(name="Duration_Of_Journey")
	private LocalTime duration;
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getSource() {
		return source;
	}


	public void setSource(String source) {
		this.source = source;
	}


	public String getDestination() {
		return destination;
	}


	public void setDestination(String destination) {
		this.destination = destination;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public int getFare() {
		return fare;
	}


	public void setFare(int fare) {
		this.fare = fare;
	}


	public LocalDate getDate() {
		return date;
	}


	public void setDate(LocalDate date) {
		this.date = date;
	}


	public LocalTime getDeparture() {
		return departure;
	}


	public void setDeparture(LocalTime departure) {
		this.departure = departure;
	}


	public LocalTime getArrival() {
		return arrival;
	}


	public void setArrival(LocalTime arrival) {
		this.arrival = arrival;
	}


	public LocalTime getDuration() {
		return duration;
	}


	public void setDuration(LocalTime duration) {
		this.duration = duration;
	}


	@Override

	public String toString() {

		return "FlightDetails [id=" + id + ", name=" + name + ", source=" + source + ", destination=" + destination

				+ ", type=" + type + ", fare=" + fare + ", date=" + date + ", departure=" + departure + ", arrival="

				+ arrival + ", duration=" + duration + "]";

	}
 
 
}

 