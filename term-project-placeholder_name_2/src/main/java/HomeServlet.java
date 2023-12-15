import tables.*;

import java.util.List;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.time.DayOfWeek;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LocalDate currentDate = LocalDate.now();
	private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd");
	List<Reservation> reservations = null;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
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
		
		PreparedStatement preparedStatement = null;
		Connection connection = null;
		
		try {
			currentDate = LocalDate.now();
			LocalDate startOfWeek = currentDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));
			LocalDate endOfWeek = currentDate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));
			
			request.setAttribute("sundayNum", startOfWeek.format(formatter));
			request.setAttribute("saturdayNum", endOfWeek.format(formatter));
			
			DBConnection.getDBConnection();
			connection = DBConnection.connection;
			
			String selectSQL = "SELECT * FROM reservation WHERE datetime_start BETWEEN ? AND ?";
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setObject(1, LocalDateTime.of(startOfWeek, LocalTime.MIN));
			preparedStatement.setObject(2, LocalDateTime.of(endOfWeek, LocalTime.MAX));
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				int machine_id = rs.getInt("machine_id");
				String username = rs.getString("username");
				LocalDateTime start = rs.getTimestamp("start_time").toLocalDateTime();
				LocalDateTime end = rs.getTimestamp("end_time").toLocalDateTime();
				
				System.out.println("Machine: " + machine_id + "Username: " + username + ", Start: " + start + ", End: " + end);
				reservations.add(new Reservation(machine_id, username, start, end));
						
			}
			/* TEMPORARY MANUAL CREATION OF RESERVATIONS FOR TESTING */
//			reservations.add(new Reservation(1, "jsmith", LocalDateTime.of(2023, 11, 16, 9, 30), LocalDateTime.of(2023, 11, 16, 10, 0)));
//			reservations.add(new Reservation(2, "jsmith", LocalDateTime.of(2023, 11, 16, 9, 15), LocalDateTime.of(2023, 11, 16, 9, 45)));
			/* COMMENT OUT WHEN PROPERLY SET UP */
			rs.close(); 
			preparedStatement.close();
			connection.close();
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		     try {
		         if (preparedStatement != null) {
		            preparedStatement.close();
		         }
		      } catch (SQLException se2) {
		    	  se2.printStackTrace();
		      }
		      try {
		         if (connection != null) {
		            connection.close();
		         }
		      } catch (SQLException se) {
		         se.printStackTrace();
		      }
	    }
		
		request.setAttribute("reservations", reservations);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/Home.jsp");
		dispatcher.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	

}
