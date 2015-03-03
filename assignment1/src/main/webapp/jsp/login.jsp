<%@ page import="ca.utoronto.ece1779.database.User" %>

<%
	// If already logged in, redirect to view_images
	if (session.getAttribute("username") != null){
		response.sendRedirect("view_images.jsp");
		return;
	}

	// Check for parameters, if avail, log them in
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	if (username != null &&
		password != null){
		User usr = User.findUser(username);
		if (usr == null){
			out.println("<div class=\"alert alert-danger\" role=\"alert\">User Not Found!</div>");
		} else {
			if (!usr.getPassword().equals(password)){
				out.println("<div class=\"alert alert-danger\" role=\"alert\">Incorrect Password</div>");
			} else {
				session.setAttribute("username",username);
				response.sendRedirect("view_images.jsp");
				return;
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
        <!-- Custom styles for this template -->
		<!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <link href="../css/signin.css" rel="stylesheet">
   		<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>

	<body>
        <div class="container">
            <form class="form-signin" name="sign_in_form" action="/ece1779/jsp/login.jsp" method="post">
              <h1 class="form-signin-heading">ECE1779 A1</h1>
              <h2 class="form-signin-heading">Please login or</br><a href="/ece1779/jsp/createaccount.jsp">create an account</a>.</h2>

              <label for="username" class="sr-only">Username</label>
              <input type="text" id="username" name="username" class="form-control" placeholder="Username" required autofocus>
              <label for="inputPassword" class="sr-only">Password</label>
              <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
              <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
            </form>
        </div>
	</body>
</html>
