<%@ page import="ca.utoronto.ece1779.database.User" %>

<%
	// If already logged in, redirect to view_images
	if (session.getAttribute("username") != null){
		response.sendRedirect("view_images.jsp");
	}

	// Check for parameters, if avail, log them in
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	if (username != null &&
		password != null){
		User usr = User.findUser(username);
		if (usr == null){
			out.println("USER NOT FOUND");
		} else {
			if (!usr.getPassword().equals(password)){
				out.println("INCORRECT PASSWORD");
			} else {
				session.setAttribute("username",username);
				response.sendRedirect("view_images.jsp");
			}
		}
	}

%>

<!DOCTYPE html>
<html>
	<head>
		<title>Welcome! Please login.</title>
		<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE" />
		<meta charset="utf-8">
		<script>
		</script>
	</head>

	<body>

    <div>
      <h1>ECE1779 Project 1 - Welcome!</h1>
      <h2>Please login or <a href="/ece1779/jsp/createaccount.jsp">create an account</a>.</h2> 
    </div> 

	<form name="sign_in_form" action="/ece1779/jsp/login.jsp" method="post">
		<table>
			<tr>
				<td><label>Username</label></td>
				<td><input type="text" name="username"/></td>
			</tr>
			<tr>
				<td><label>Password</label></td>
				<td><input type="password" name="password"/></td>
			</tr>
			<tr>
				<td colspan=2><input type="submit" value="Login" /></td>
			</tr>
		</table>
	</form>
	
	</body>

</html>
