import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// get request parameters for userID and password
		String user = request.getParameter("usr");
		String pwd = request.getParameter("pwd");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String phone = request.getParameter("phone");
		String email = request.getParameter("mail");
		
		Connection connection = null; 
		String insertSql = "INSERT INTO user_info values (?, ?, ?, ?, ?, ?)";
		try {
			DBConnection.getDBConnection();
			connection = DBConnection.connection; 
			PreparedStatement preparedStmt = connection.prepareStatement(insertSql);
			preparedStmt.setString(1, user);
			preparedStmt.setString(2, pwd);
			preparedStmt.setString(3, fname);
			preparedStmt.setString(4, lname);
			preparedStmt.setString(5, phone);
			preparedStmt.setString(6, email);
			preparedStmt.execute();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("login_signup.html");
		
	}


}