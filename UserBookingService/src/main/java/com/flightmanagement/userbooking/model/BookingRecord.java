package com.flightmanagement.userbooking.model;

import jakarta.persistence.*;

@Entity
@Table(name = "booking_record")
public class BookingRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username")
    private String username;

    @ManyToOne
    @JoinColumn(name = "flight_id")
    private FlightDetails flight;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public FlightDetails getFlight() {
        return flight;
    }

    public void setFlight(FlightDetails flight) {
        this.flight = flight;
    }
}
