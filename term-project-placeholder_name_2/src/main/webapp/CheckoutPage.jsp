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
		if(session.getAttribute("user") == null){
			response.sendRedirect("login.html");
		}
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if(cookies !=null){
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("user")) userName = cookie.getValue();
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
	
		<p><%=userName %>, we are sorry to see you go.</p>
		<br>
		
		<form action="LogoutServlet" method="post">
			<input type="submit" value="Logout" >
		</form>
	</body>
</html>