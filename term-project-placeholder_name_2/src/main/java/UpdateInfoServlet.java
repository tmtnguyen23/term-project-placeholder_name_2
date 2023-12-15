import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ReserveLaptop
 */
@WebServlet("/UpdateInfoServlet")
public class UpdateInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateInfoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String npwd = request.getParameter("pwd");
		String nfname = request.getParameter("fname");
		String nlname = request.getParameter("lname");
		String nphone = request.getParameter("phone");
		String nmail = request.getParameter("mail");
		
		
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("user");
			
		informUser(userName, npwd, nfname, nlname, nphone, nmail, response);
	}
	
	void informUser(String username, String password, String firstname, String lastname, String phone, String email, HttpServletResponse response) throws ServletException, IOException{
		PreparedStatement preparedStatement = null;
		Connection connection = null;
		
		try {
			DBConnection.getDBConnection();
			connection = DBConnection.connection;
			
			if (password.isEmpty()==false) {
				String updateSQL = "UPDATE user_info SET password = ? WHERE username LIKE ?";
				preparedStatement = connection.prepareStatement(updateSQL);
				preparedStatement.setString(1,password);
				preparedStatement.setString(2,username);
				preparedStatement.executeUpdate();
				preparedStatement.close();
			}
			if (firstname.isEmpty()==false) {
				String updateSQL = "UPDATE user_info SET fname = ? WHERE username = ?";
				preparedStatement = connection.prepareStatement(updateSQL);
				preparedStatement.setString(1,firstname);
				preparedStatement.setString(2,username);
				preparedStatement.executeUpdate();
				System.out.println(username + firstname);
				preparedStatement.close();
			}
			if (lastname.isEmpty()==false) {
				String updateSQL = "UPDATE user_info SET lname = ? WHERE username LIKE ?";
				preparedStatement = connection.prepareStatement(updateSQL);
				preparedStatement.setString(1,lastname);
				preparedStatement.setString(2,username);
				preparedStatement.executeUpdate();
				preparedStatement.close();
			}
			if (phone.isEmpty()==false) {
				String updateSQL = "UPDATE user_info SET phone = ? WHERE username = ?";
				preparedStatement = connection.prepareStatement(updateSQL);
				preparedStatement.setString(1,phone);
				preparedStatement.setString(2,username);
				preparedStatement.executeUpdate();
				preparedStatement.close();
			}
			if (email.isEmpty()==false) {
				String updateSQL = "UPDATE user_info SET email = ? WHERE username LIKE ?";
				preparedStatement = connection.prepareStatement(updateSQL);
				preparedStatement.setString(1,email);
				preparedStatement.setString(2,username);
				preparedStatement.executeUpdate();
				preparedStatement.close();
			} 
			connection.close();
			response.sendRedirect("MngAcct.jsp");
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
