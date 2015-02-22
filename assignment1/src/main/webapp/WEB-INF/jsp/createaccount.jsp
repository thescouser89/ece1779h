<%@ page import="ca.utoronto.ece1779.database.User" %>

<%
	// If already logged in, redirect to view_images
	if (session.getAttribute("username") != null){
		response.sendRedirect("view_images.jsp");
	}

	// Check for parameters, if avail, log them in
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String password_2 = request.getParameter("password_2");
	if (username != null &&
		password != null && password_2 != null){
		if (!password.equals(password_2)){
			out.println("PASSWORDS DON'T MATCH!");
		} else {
			if (User.findUser(username) != null){
				out.println("USERNAME ALREADY TAKEN!");
			} else {
				if (User.addUser(new User(username,password))){
					// log them in
					session.setAttribute("username",username);
					response.sendRedirect("view_images.jsp");
				} else {
					out.println("COULD NOT CREATE ACCOUNT!");
				}
			}
		}
	}

%>

<!DOCTYPE html>
<html>
	<head>
		<title>Account Creation</title>
		<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE" />
		<meta charset="utf-8">
		<script>
			function validateForm(){
				if (document.getElementById("id_pw2").value != document.getElementById("id_pw1").value){
					alert("Your passwords do not match!");
					return false;
				}
			}
		</script>
	</head>

	<body>

    <div>
      <h1>Account Creation</h1>
    </div> 

	<form name="sign_up_form" action="/ece1779/jsp/createaccount.jsp" method="post" onsubmit="return validateForm();">
		<table>
			<tr>
				<td><label>Username</label></td>
				<td><input type="text" name="username"/></td>
			</tr>
			<tr>
				<td><label>Password</label></td>
				<td><input id="id_pw1" type="password" name="password"/></td>
			</tr>
			<tr>
				<td><label>Retype Password</label></td>
				<td><input id="id_pw2" type="password" name="password_2"/></td>
			</tr>
			<tr>
				<td colspan=2><input type="submit" value="Create Account"/></td>
			</tr>
		</table>
	</form>
	
	</body>

</html>
