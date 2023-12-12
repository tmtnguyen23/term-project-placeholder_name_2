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
<% // Java code goes in this section

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

<!-- TODO: delete these div and nav sections below if desired — not sure if we want on every page or not -->
    <div class="logo-container" style="display:flex">
        <img src="logo.png" alt="our company logo" width="100px" height = "100px">
        <h1>Placeholder Laundromat</h1>
    </div>
	
    <nav>
       <ul>
           <li><a href="#">Reservations</a></li>
           <li><a href="#">New Reservation</a></li>
           <li><a href="#">Report Issue</a></li>
           <li><a href="#">Contact us</a></li> 
       </ul>
   	</nav>
   	
   	<!-- line below references Java code in Java section above -->
   	<h3>Welcome <%=userName%>!</h3> 
       <ul>
           <li>Want to log out? <a href = "CheckoutPage.jsp">Click here</a></li>
       </ul>  

<!-- TODO: footer section here, same as in Home.jsp file? Not sure if we want that across the whole website or not -->

</body>


</html>