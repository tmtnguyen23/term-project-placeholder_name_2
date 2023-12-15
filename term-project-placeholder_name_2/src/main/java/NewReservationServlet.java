

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// For time/date formatting
import java.time.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.sql.Timestamp;

/**
 * Servlet implementation class NewReservation
 */
@WebServlet("/NewReservationServlet")
public class NewReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewReservationServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO: delete if not needed 
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String date = request.getParameter("date");
		String startTime = request.getParameter("start");
		String endTime = request.getParameter("end");
		
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("user");
			
		informUser(userName, date, startTime, endTime, response);
	}
	
	void informUser(String username, String date, String startTime, String endTime, HttpServletResponse response) throws ServletException, IOException{
		PreparedStatement preparedStatement = null;
		Connection connection = null;
		
		try {
			DBConnection.getDBConnection();
			connection = DBConnection.connection;
			
			if (date.isEmpty()==false) {
				// Using 1 as default machine ID below for now
				String insertSQL = "INSERT INTO reservations(machine_id, username, start_time, end_time) VALUES (1, ?, ?, ?)";
				String startDateTimeString = date + " " + startTime;
				String endDateTimeString = date + " " + endTime;
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date startDateTime = null;
				Date endDateTime = null;
				
				try {
					
					startDateTime = dateFormat.parse(startDateTimeString);
					endDateTime = dateFormat.parse(endDateTimeString);
					
					// Check if start time is before end time
					if (startDateTime.after(endDateTime)) {
						System.out.println("Start time must be before end time.");
					}
					
					// Check if time between start and end is greater than 15 mins
					long timeDiff = endDateTime.getTime() - startDateTime.getTime();
					if (timeDiff < (15 * 60 * 1000)) { // 15 mins in milliseconds
						System.out.println("Time between start and end times must be greater than 15 minutes.");
						return;
					}
					
					// Make sure start time is not before current time
					Date currentTime = new Date();
					if (startDateTime.before(currentTime)) {
						System.out.println("Start time must be before the current time.");
						return;
					}
					
					// Make sure start and end times are in hour range 
					Calendar cal  = Calendar.getInstance();
					cal.setTime(startDateTime);
					int startHr = cal.get(Calendar.HOUR_OF_DAY);
					
					cal.setTime(endDateTime);
					int endHr = cal.get(Calendar.HOUR_OF_DAY);
					
					if (startHr < 8 || endHr > 20) {
						System.out.println("Start and end times must be on the same day during store hours.");
						return;
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				String finalStartTime = startDateTime.toString();
				String finalEndTime = endDateTime.toString();
				
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, finalStartTime);
				preparedStatement.setString(3, finalEndTime);
				preparedStatement.executeUpdate();
				preparedStatement.close();
			} 
			connection.close();
			response.sendRedirect("ReservationForm.jsp");
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
