<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%> 
<%@ page import="java.util.*, java.time.*, java.time.temporal.*, java.time.format.*, tables.*" %>
<%-- <%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>
<%@ page import="java.time.temporal.TemporalAccessor" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.DayOfWeek" %>

<%@ page import="tables.*" %> --%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="styleCal.css">
</head>

<body>
	<%
		//allow access only if session exists
		String user = null;
		if(session.getAttribute("user") == null){
			response.sendRedirect("login.html");
		} else user = (String) session.getAttribute("user");
		
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		
		if(cookies !=null){
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("user")) userName = cookie.getValue();
				if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
			}
		}
	%>
	
    <div class="logo-container" style="display:flex">
        <img src="logo.png" alt="our company logo" width="100px" height = "100px">
        <h1> Placeholder Laundromat </h1>
    </div>
	
    <nav>
       <ul>
           <li><a href="Home.jsp">View Reservations</a></li>
           <li><a href="ReservationForm.jsp">New Reservation</a></li>
           <li><a href="MngAcct.jsp">Manage Account</a></li>
           <li><a href="aboutus.html">About Us</a></li> 
       </ul>
   	</nav>
	
	
	<div class="calendar-topbar">
		<%
			LocalDate currentDate = LocalDate.now();
			Month month = currentDate.getMonth();
			int year = currentDate.getYear();
			String calendarHeader = "" + month + " " + year;
		%>
			<h2> <%=calendarHeader %>
			</h2>
			

		</h2>
	</div>
	
	<div class="calendar-container">
		<div class="header">
			<ul class="weekdays">
				<li>Sunday</li>
				<li>Monday</li>
				<li>Tuesday</li>
				<li>Wednesday</li>
				<li>Thursday</li>
				<li>Friday</li>
				<li>Saturday</li>
			</ul>
			
			<ul class="daynumbers">
			<%
			 	DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("dd");
				// LocalDate currentDate = LocalDate.now();
				
				LocalDate startOfWeek = currentDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
				System.out.println("start of week: " + startOfWeek.toString());
				LocalDate endOfWeek = currentDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));
				System.out.println("end of week: " + endOfWeek.toString());
				
				int sundayNum = Integer.valueOf(startOfWeek.format(dayFormatter));
				int saturdayNum = Integer.valueOf(endOfWeek.format(dayFormatter));
				
				LocalDate iDate = currentDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
				
				for (int i = 0; i <= 6; i++)
				{
					int iDayNum = iDate.getDayOfMonth();
			%>
				<li><%=iDayNum%></li>
			<%
					iDate = iDate.plusDays(1);
				}
			%>
			</ul>
		</div>
		
		<div class="timeslots-container">
			<ul class="timeslots">
				<li>8:00 AM</li>
				<li>9:00 AM</li>
				<li>10:00 AM</li>
				<li>11:00 AM</li>
				<li>12:00 PM</li>
				<li>1:00 PM</li>
				<li>2:00 PM</li>
				<li>3:00 PM</li>
				<li>4:00 PM</li>
				<li>5:00 PM</li>
				<li>6:00 PM</li>
				<li>7:00 PM</li>
				<li>8:00 PM</li>
			</ul>
		</div>
		
		
		<div class="reservation-container">
			<%
				// Helper functions for creating display cells
				int timeIntervalInMinutes = 15;
				int pixelsPerMinute = 1;
				int columnWidth = 100;
				
				
				// Create table for gridcells
				
				
				
				
				
			%>
			
			<%
				// temporarily creating these myself to test formatting]
				List<Reservation> reservations = new ArrayList<Reservation>();
				
				// reservations = (List<Reservation>) (request.getAttribute("reservations"));
				// try to convert reservations attribute back to List<Reservation>
				boolean shouldGenerateTemps = true;
						
				
						
						
				if (shouldGenerateTemps)
				{
					// Test: Complex day schedule
					LocalDateTime ldt = LocalDateTime.now().with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
					Reservation A = new Reservation(0, "jdoe", ldt.with(LocalTime.of(8, 0)), ldt.with(LocalTime.of(8, 30)));
					Reservation B = new Reservation(1, "jdoe", ldt.with(LocalTime.of(8, 0)), ldt.with(LocalTime.of(8, 30)));
					Reservation C = new Reservation(2, "jsmith", ldt.with(LocalTime.of(8, 30)), ldt.with(LocalTime.of(9, 0)));
					Reservation D = new Reservation(0, "jdoe", ldt.with(LocalTime.of(9, 0)), ldt.with(LocalTime.of(9, 30)));
					Reservation E = new Reservation(3, "jsmith", ldt.with(LocalTime.of(9, 0)), ldt.with(LocalTime.of(10, 15)));
					Reservation F = new Reservation(2, "jdoe", ldt.with(LocalTime.of(9, 30)), ldt.with(LocalTime.of(10, 0)));
					Reservation G = new Reservation(0, "jsmith", ldt.with(LocalTime.of(9, 45)), ldt.with(LocalTime.of(10, 15)));
					Reservation H = new Reservation(1, "jsmith", ldt.with(LocalTime.of(10, 15)), ldt.with(LocalTime.of(10, 45)));
					
					reservations.add(A);
					reservations.add(B);
					reservations.add(C);
					reservations.add(D);
					reservations.add(E);
					reservations.add(F);
					reservations.add(G);
					reservations.add(H);
					
					
					// Test: reservation spacing for each day
					ldt = ldt.with(LocalTime.of(15, 0));
					for (int i = 0; i < 7; i++)
					{
						int rnd1 = new Random().nextInt(2);
						String name = (rnd1 == 0) ? "jdoe" : "jsmith";
						name="day";
						int rnd2 = new Random().nextInt(4);
						reservations.add(new Reservation(rnd2, name, ldt.with(LocalTime.of(15,0)), ldt.with(LocalTime.of(15, 30))));
						
						ldt = ldt.plusDays(1);
					}
					
					
					// Test: spacing for each machine
					LocalDateTime ldt1 = LocalDateTime.now().with(LocalTime.of(12,0));
					LocalDateTime ldt2 = LocalDateTime.now().with(LocalTime.of(12,30));
					for (int i = 0; i < 8; i++)
					{
						reservations.add(new Reservation(i, "machine-test", ldt1, ldt2));
					}
					
					
					// print out week's reservations
					for (Reservation reservation : reservations)
					{
						System.out.println(reservation.toString());
					}
					
					
				}
				
				String[] colors = {"red", "green", "blue", "purple", "darkcyan", "royalblue", "cadetblue", "brown", "black"};
				int timeslotInterval = 15;
				LocalDateTime openTime = LocalDateTime.now().with(LocalTime.of(8, 0));
				int daysPerWeek = 7;
				int sections = daysPerWeek;
				
				List<List<Reservation>> reservationsForWeek = new ArrayList<>();
				for (int z = 0; z < daysPerWeek; z++)
				{
					reservationsForWeek.add(new ArrayList<>());
				}
				
				for (Reservation reservation : reservations)
				{
					int col = (int) ChronoUnit.DAYS.between(startOfWeek, reservation.getStartTime());
					// System.out.println("col: " + col);
					reservationsForWeek.get(col).add(reservation);
				};
				
				// int i = 0;
			
				for (int dayIndex = 0; dayIndex < daysPerWeek; dayIndex++) // was y
				{
					// Create a list of all reservations for the current day
					List<Reservation> reservationsForDay = new ArrayList<>();
					for (Reservation reservation : reservationsForWeek.get(dayIndex))
					{
						reservationsForDay.add(reservation);
					}
					
					// Sort by start_time
					Collections.sort(reservationsForDay, (reservation1, reservation2) -> 
						reservation1.getStartTime().compareTo(reservation2.getStartTime())
					);
					
					// Check for overlaps
					/*
					for (int i = 0; i < reservationsForDay.size(); i++)
					{
						Reservation res1 = reservationsForDay.get(i);
						for (int j = i + 1; j < reservationsForDay.size(); j++)
						{
							Reservation res2 = reservationsForDay.get(j);
							
							if (res1.overlapsWith(res2))
							{
								res1.addOverlap(res2);
								res2.addOverlap(res1);
							}
							// Since reservations are ordered by start_time, as soon as one doesn't overlap, none of the following will
							else
							{
								break;	
							}
						}
					}
					*/
					
					int i = 0;
					for (Reservation reservation : reservationsForDay)
					{
						LocalDateTime dayOpenTime = reservation.getStartTime().with(LocalTime.of(8, 0));
						int gridColStart = (int) ChronoUnit.DAYS.between(startOfWeek, reservation.getStartTime()) + 1;
						System.out.println("start: " + startOfWeek + "res: " + reservation.getStartTime());
						System.out.println(gridColStart);
						%>
						<div class="slot slot-<%=i%>" 
							style="
								background-color: <%=colors[reservation.getMachineID()] %>; 
								width: <%=100/8 + "px"%>; 
								left: <%=reservation.getMachineID() * 100/8 + "px"%>; 
								height: <%=reservation.getDuration() + "px"%>; 
								grid-column-start: <%=((int) ChronoUnit.DAYS.between(startOfWeek, reservation.getStartTime()) * 8) + 1 + ""%>; 
								grid-row-start: <%=((int) ChronoUnit.MINUTES.between(dayOpenTime, reservation.getStartTime()) / 15 ) + 1 + "" %>; 
								z-index: <%=1%>;"
						><%=reservation.getMachineID() %></div>
						<%
						++i;
					}
					
					// Create a ReservationCell for each Reservation.
					// List<Reservation> ReservationCells = new ArrayList<>();
							
					
				
				
				
				
					// System.out.println(reservationsByDay.get(y));
					// int offset = 0;
					/*
					for (Reservation reservation : reservationsByDay.get(y))
					{
						// int dayNum = Integer.valueOf(reservation.getStartTime().format(dayFormatter));
						// int col = Math.abs(dayNum - sundayNum);
						
						int col = (int) ChronoUnit.DAYS.between(startOfWeek, reservation.getStartTime());
						
						/*
						double percentWidth = Math.floor((100.0 / (sections + 1 - col)));
						percentWidth = percentWidth / reservationsByDay.get(y).size();
						
						double widthMult = 1.2;
						if (offset == reservationsByDay.get(y).size())
						{
							widthMult = 0.95;
						}
						
						int rnd = new Random().nextInt(colors.length);
						
						String slotBackground = colors[rnd];
						String slotWidth = (percentWidth * widthMult) + "%";
						String slotLeft = (percentWidth * offset) + "%";
						*/
						
						
						
						/*
						// get height
						LocalDateTime start = reservation.getStartTime();
						LocalDateTime end = reservation.getEndTime(); 
						
						long minutes = ChronoUnit.MINUTES.between(start, end);
						
						double durHeight = (double) minutes;
						String slotHeight = durHeight + "px";
						*/
						
						/*
						// get grid location
						String gridColStart = String.valueOf(col);
						String gridRowStart;
						
						long minutesAfterOpen = ChronoUnit.MINUTES.between(openTime, start);
						int rowPos = (int) minutesAfterOpen / timeslotInterval + 1;
						gridRowStart = String.valueOf(rowPos);
						
						System.out.println("col: ");
						*/
						
						
						// create reservation slot

						
						// ++i;
						// ++col;
						// ++offset;
						
					// } */
					
					
					
				}
						
			%>
		</div> 
	</div>

</body>

</html>