

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.time.*;

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
		
		
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("user");
			
		informUser(userName, date, startTime, response);
		response.sendRedirect("Confirmation.jsp");
	}
	
	void informUser(String username, String date, String startTime, HttpServletResponse response) throws ServletException, IOException{
		PreparedStatement preparedStatement = null;
		Connection connection = null;
		
		try {
			DBConnection.getDBConnection();
			connection = DBConnection.connection;
			
			if (date.isEmpty()==false) {
				// Using 1 as default machine ID below for now
				String insertSQL = "INSERT INTO reservations(reservation_id, machine_id, username, start_time, end_time) VALUES (default, 1, ?, ?, ?)";
				String startDateTime = date + " " + startTime;
				// Time format example: 08:01
				String formattedEnd = "" + Integer.parseInt(startTime.substring(0, 3)) + "" + Integer.parseInt(startTime.substring(0,startTime.length()))+3 + Integer.parseInt(startTime.substring(4));
				// TODO: debug
				System.out.println("" + Integer.parseInt(startTime.substring(0, 3)) + "" + Integer.parseInt(startTime.substring(0,startTime.length()))+3 + Integer.parseInt(startTime.substring(4)));
				String endDateTime = date + " " + formattedEnd; 
				System.out.println(endDateTime);
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, startDateTime);
				preparedStatement.setString(3, endDateTime);
				preparedStatement.close();
			} 
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
