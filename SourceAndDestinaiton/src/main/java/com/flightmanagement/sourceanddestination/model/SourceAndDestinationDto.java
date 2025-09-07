package com.flightmanagement.sourceanddestination.model;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class SourceAndDestinationDto {
	private List<FlightDetails> flightList;
	private boolean anyError;
	private boolean isEmpty;
	public List<FlightDetails> getFlightList() {
		return flightList;
	}
	public void setFlightList(List<FlightDetails> flightList) {
		this.flightList = flightList;
	}
	public boolean getAnyError() {
		return anyError;
	}
	public void setAnyError(boolean anyError) {
		this.anyError = anyError;
	}
	public boolean getIsEmpty() {
		return isEmpty;
	}
	public void setIsEmpty(boolean isEmpty) {
		this.isEmpty = isEmpty;
	}
	
	
}
