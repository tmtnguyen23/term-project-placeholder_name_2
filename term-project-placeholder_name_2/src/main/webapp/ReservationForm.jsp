<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
    <title>New Reservation Form</title>

    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<!--  TODO: Update information above this line if necessary — taken from Contact.jsp page to start -->

<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
	
<% // Java code goes in this section
	
	// set up the database information

	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://ec2-34-238-172-16.compute-1.amazonaws.com:3306/LaundryDB?allowPublicKeyRetrieval=true&useSSL=false";
	String userId = "remote";
	String datapass = "password";
	
	Class.forName(driverName);

	// allow access to this page only if session exists/user is signed in
	String user = null;
	String pass = null;
	String fName = null;
	String lName = null;
	String pNum = null;
	String add = null;
	
	if(session.getAttribute("user") == null){
		response.sendRedirect("login.html");
	} else user = (String) session.getAttribute("user");
	
	String userName = null;
	String password = null;
	String firstName = null;
	String lastName = null;
	String phone = null;
	String email = null;
	
	String sessionID = null;
	Cookie[] cookies = request.getCookies();
	
	if(cookies !=null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")) userName = cookie.getValue();
			if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
		}
		
		Connection connection = null; 
		connection = DriverManager.getConnection(connectionUrl, userId, datapass);
		
		if (connection != null) {
			PreparedStatement preparedStatement = null;
		    
		    String selectSQL = "SELECT * FROM user_info WHERE username LIKE ?";
		    String key = userName; 
		    preparedStatement = connection.prepareStatement(selectSQL);
		    preparedStatement.setString(1, key);
		    
		    ResultSet rs = preparedStatement.executeQuery();
		    
		    if (rs.next()) {
			    firstName = rs.getString("fname").trim();
		        lastName = rs.getString("lname").trim();
		        phone = rs.getString("phone").trim();
		        email = rs.getString("email").trim();
		    } else {
		    	System.out.println("Failed to make connection!");
		    }
		}
	}
%>

<!-- TODO: header section, same as in Home.jsp file. Should we implement this in a shared library? --> 
   	<div class="site-header">
	   	<div class="user-container" style="float:right; padding: 10px">
	       	<p> Logged in as <%=userName %>. <a href="CheckoutPage.jsp">&lt;log out&gt;</a></p>
	    </div>
	    <div class="logo-container" style="display:flex">
	        <img src="logo.png" alt="our company logo" width="100px" height = "100px">
	        <h1>LaundroMatch</h1>
	    </div>
	</div>
    <nav>
       <ul>
           <li><a href="Home.jsp">Reservations</a></li>
           <li><a href="ReservationForm.jsp">New Reservation</a></li>
           <li><a href="MngAcct.jsp">Manage Account</a></li> 
           <li><a href="aboutus.html">About Us</a></li> 
       </ul>
   	</nav>
   	
   	<!-- line below references Java code in Java section above -->
   	<h3>Welcome, <%=user%>! Enter information below to make a new reservation.</h3>
   	<br>

	<!-- Find a way to check that confirmation was successfully added before routing to reservation page? -->
	<form action="Confirmation.jsp" method="post">
		Date: <input type = "date" id = 'date' name = "date"/><br>
		Start time: <input type = "time" id = 'start' name = "start" min = "8:00" max = "19:45"/><br>
		End time: <input type = "time" id = 'end' name = "end" min = "8:15" max = "20:00"/><br>
		<input type="submit" value="Submit"/><br>
		
		<!-- TODO: figure out how to submit reservation ID and username with this form -->
	</form>

<!-- TODO: footer section, same as in Home.jsp file. Should we implement this in a shared library? -->

	<footer class="footer">
  	 <div class="container">
  	 	<div class="row">
  	 		<div class="footer-col">
  	 			<h4>Our address</h4>
  	 			<ul>
  	 				<li>Placeholder Laundromat</li>
  	 				<li>6001 Dodge Street</li>
  	 				<li>Omaha, NE 68107</li>
  	 			</ul>
  	 		</div>
  	 	</div>
  	 </div>
  	</footer>

</body>


</html>