<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Contact Us</title>
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
    <body>
    	<h3>Welcome <%=userName %></h3>
        <p>
        Thank you for choosing us! If you need assistance, please reach out to us by: 
        </p>
        <ul>
            <li>Phone: 402-111-1234</li>
            <li><a href = "mailto: checkoutlaptop@infinity.com">Send Email</a></li>
            <li>Want to log out? <a href = "CheckoutPage.jsp">Click here</a></li>
        </ul>  
    </body>
</body>
</html>