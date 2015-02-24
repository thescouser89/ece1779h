<%@ page import="ca.utoronto.ece1779.database.User" %>

<%
	// If logged in, log them out
	if (session.getAttribute("username") != null){
		session.setAttribute("username",null);
	}
	response.sendRedirect("login.jsp");
%>

