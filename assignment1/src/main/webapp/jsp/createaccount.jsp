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
		        <!-- Custom styles for this template -->
        <link href="../css/signin.css" rel="stylesheet">
        <link href="../css/sweet-alert.css" rel="stylesheet">
		<!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <script src="../js/sweet-alert.min.js"></script>
		<script>
			function validateForm(){
				if (document.getElementById("id_pw2").value != document.getElementById("id_pw1").value){
					swal("Oops...", "Your passwords do not match!", "error");
					return false;
				}
			}
		</script>
	</head>

	<body>
        <div class="container">
            <form class="form-signin" name="sign_up_form" action="/ece1779/jsp/createaccount.jsp" method="post" onsubmit="return validateForm();">
                <h1 class="form-signin-heading">ECE1779 A1</h1>
                <h2 class="form-signin-heading">Account Creation</h2>
                <label for="username" class="sr-only">Username</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Username" required autofocus>

                <label for="inputPassword" class="sr-only">Password</label>
                <input type="password" id="id_pw1" name="password" class="form-control" placeholder="Password" required>
                <label for="inputPassword" class="sr-only">Retype Password</label>
                <input type="password" id="id_pw2" name="password_2" class="form-control" placeholder="Password Again" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Create Account</button>
            </form>
        </div>
	</body>
</html>
