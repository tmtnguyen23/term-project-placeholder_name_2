<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation</title>

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

	// allow access to this page only if session exists/user is signed in
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

<!-- TODO: header section, same as in Home.jsp file. Should we implement this in a shared library? --> 
   	<div class="site-header">
	   	<div class="user-container" style="float:right; padding: 10px">
	       	<p> Logged in as <%=userName %>.<a href="CheckoutPage.jsp">&lt;log out&gt;</a></p>
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
   	<h4 id="confirm-message">Confirmed! Your reservation was added.</h4> 
   	<p>Please let our store assistant know when you come in so that we could better assist you with finding your reserved machine.</p> 

<!-- TODO: footer section, same as in Home.jsp file. Should we implement this in a shared library? -->

	<footer class="footer">
  	 <div class="container">
  	 	<div class="row">
  	 		<div class="footer-col">
  	 			<h4>Our address</h4>
  	 			<ul>
  	 				<li>LaudroMatch</li>
  	 				<li>6001 Dodge Street</li>
  	 				<li>Omaha, NE 68107</li>
  	 			</ul>
  	 		</div>
  	 	</div>
  	 </div>
  	</footer>

</body>


</html>