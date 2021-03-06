<%@ page import="ca.utoronto.ece1779.database.Image" %>
<%@ page import="ca.utoronto.ece1779.database.User" %>
<%@ page import="ca.utoronto.ece1779.amazon.ImageUploader" %>

<%
	// If not logged in, redirect to login
	if (session.getAttribute("username") == null){
		response.sendRedirect("login.jsp");
	}

	// Get user's images
	String username = (String) session.getAttribute("username");
	//for (Image im : Image.findImagesWithUserId(User.findUser(username).getId())){
	//	out.println(im.getOriginalImage());
	//}

	String bucket = ImageUploader.BUCKET;

%>

<!DOCTYPE html>
<html>
	<head>
		<title>My Images</title>
		<meta charset="utf-8">
    	<!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <link href="../css/signin.css" rel="stylesheet">

   		<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>

	<jsp:include page="includes/header.jsp" />

	<body>
	    <div class="container">
            <h1 class="text-center">My Images</h1>

            <div class="row">
                <!--%
                    for (int i=0; i < imageArray.length; i++)
                    {
                %-->

                <%
                    if (session.getAttribute("username") != null)
                    for (Image im : Image.findImagesWithUserId(User.findUser(username).getId())){
                        out.println("<div class='col-md-2'>");
                        out.println("<a href='/ece1779/jsp/view_image.jsp?imageid="+im.getId()+"'><img class='img-thumbnail' style='height:200px;padding:5px;' src='http://" + bucket + ".s3-us-west-2.amazonaws.com/"+im.getOriginalImage()+"' /></a>");
                        out.println("</div>");
                    }
                %>

                <!--%
                    }
                %-->
            </div>
        </div>
	</body>
</html>
