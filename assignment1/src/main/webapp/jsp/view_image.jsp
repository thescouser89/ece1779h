<%@ page import="ca.utoronto.ece1779.database.Image" %>
<%@ page import="ca.utoronto.ece1779.amazon.ImageUploader" %>
<%@ page import="ca.utoronto.ece1779.database.User" %>

<%
	// If not logged in, redirect to login
	if (session.getAttribute("username") == null){
		response.sendRedirect("login.jsp");
	}

	String imageidstr = request.getParameter("imageid");
	int imageid = Integer.parseInt(imageidstr);
	// Get the image
	String username = (String) session.getAttribute("username");
	String key0 = "";
	String key1 = "";
	String key2 = "";
	String key3 = "";
	String bucket = ImageUploader.BUCKET;
	for (Image im : Image.findImagesWithUserId(User.findUser(username).getId())){
		if (im.getId() == imageid){
			key0 = im.getOriginalImage();
			key1 = im.getFirstTransformation();
			key2 = im.getSecondTransformation();
			key3 = im.getThirdTransformation();
			break;
		}
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<title>My Images</title>
		<meta charset="utf-8">
    	<!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>

	<jsp:include page="includes/header.jsp" />

	<body>

    <div>
      <h1>Image <%= imageidstr %></h1>
    </div>

	<div style="width:500px;padding:0px;">
		<table>
			<tr>
				<th>Original:</th>
			</tr>
			<tr>
				<td><img style="max-width:300px;max-height:225px;float:left;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key0 %>" /></td>
			</tr>
			<tr>
				<th>Transform 1:</th>
			</tr>
			<tr>
				<td><img style="max-width:300px;max-height:225px;float:left;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key1 %>" /></td>
			</tr>
			<tr>
				<th>Transform 2:</th>
			</tr>
			<tr>
				<td><img style="max-width:300px;max-height:225px;float:left;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key2 %>" /></td>
			</tr>
			<tr>
				<th>Transform 3:</th>
			</tr>
			<tr>
				<td><img style="max-width:300px;max-height:225px;float:left;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key3 %>" /></td>
			</tr>

		</table>

	</div>

	</body>

</html>
