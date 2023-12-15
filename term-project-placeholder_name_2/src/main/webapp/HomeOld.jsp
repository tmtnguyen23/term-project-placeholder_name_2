<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="style.css">
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
	
	<div class="site-header">
		<div class="user-container" style="float:right; padding: 10px">
	       	<p> Logged in as <%=userName %>. <a href="CheckoutPage.jsp">&lt;log out&gt;</a></p>
	    </div>
	    <div class="logo-container" style="display:flex">
	        <img src="logo.png" alt="our company logo" width="100px" height = "100px">
	        <h1> Placeholder Laundromat </h1>
	    </div>
    </div>
	
    <nav>
       <ul>
           <li><a href="#">View Reservations</a></li>
           <li><a href="#">New Reservation</a></li>
           <li><a href="MngAcct.jsp">Manage Account</a></li>
           <li><a href="#">About Us</a></li> 
       </ul>
   	</nav>
	
	<h3>Thank you for choosing Placeholder Laundromat!</h3> 
	
	<p>Here are your past reservations<p>
	
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