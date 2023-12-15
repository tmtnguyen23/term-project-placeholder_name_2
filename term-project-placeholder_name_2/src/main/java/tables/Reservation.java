package tables;

import java.util.*;
import java.time.*;
import java.time.temporal.*;

public class Reservation 
{
	// SQL
	private int machine_id;
	private String username;
	private LocalDateTime start_time;
	private LocalDateTime end_time;
	
	// Other
	private List<Reservation> overlappingReservations;
	
	public Reservation(int machine_id, String username, LocalDateTime start_time, LocalDateTime end_time) 
	{
		super();
		this.machine_id = machine_id;
		this.username = username;
		this.start_time = start_time;
		this.end_time = end_time;
		
		this.overlappingReservations = new ArrayList<>();
	}
	
	@Override
	public String toString()
	{
		return "machine: " + machine_id + ", user: " + username + ", start: " + start_time.toString() + ", end: " + end_time.toString();
	}
	
	//---Helpers---//
	public boolean overlapsWith(Reservation other)
	{
		return start_time.isBefore(other.getEndTime()) && end_time.isAfter(other.getStartTime());
	}
	
	public void addOverlap(Reservation other)
	{
		this.overlappingReservations.add(other);
	}
	
	//---Getters & Setters---//
	public int getMachineID() 
	{
		return machine_id;
	}

	public void setMachineID(int machine_id) 
	{
		this.machine_id = machine_id;
	}

	public String getUsername() 
	{
		return username;
	}

	public void setUsername(String username) 
	{
		this.username = username;
	}

	public LocalDateTime getStartTime() 
	{
		return start_time;
	}

	public void setStartTime(LocalDateTime start_time) 
	{
		this.start_time = start_time;
	}

	public LocalDateTime getEndTime() 
	{
		return end_time;
	}

	public void setEndTime(LocalDateTime end_time) 
	{
		this.end_time = end_time;
	}
	
	public int getDuration()
	{
		return (int) ChronoUnit.MINUTES.between(start_time, end_time);
	}

	public List<Reservation> getOverlappingReservations()
	{
		return overlappingReservations;
	}
	
	
}
