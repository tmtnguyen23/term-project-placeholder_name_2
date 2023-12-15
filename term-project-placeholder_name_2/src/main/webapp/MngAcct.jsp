<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Account</title>

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
           <li><a href="Contact.jsp">Contact Us</a></li> 
       </ul>
   	</nav>
   	
   	<!-- line below references Java code in Java section above -->
   	<h3>Welcome, <%=userName%>! Here is your account information.</h3> 
       <ul>
       <!-- username, address, etc. (all info from database), delete account functionality, edit all fields, etc. -->
           <li>User name: <%=userName%></li>
           <li>First name: <%=firstName%></li>
           <li>Last name: <%=lastName%></li>
           <li>Phone: <%=phone%></li>
           <li>Email: <%=email%></li>
       </ul>
    <br>
    <br>
    <h3>Please the information below to edit your account information.</h3> 
    <p>You only need to fill in the information to the fields you want to change.</p>

	<form action="UpdateInfoServlet" method="post">
		Password <input type="password" name="pwd"><br>
		First name <input type="text" name="fname"><br>
		Last name <input type="text" name="lname"><br>
		Phone number <input type="number" name="phone"><br>
		Email <input type="text" name="mail"><br>
		<input type="submit" value="Submit">
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