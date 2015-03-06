<%@ page import="ca.utoronto.ece1779.database.Image" %>
<%@ page import="ca.utoronto.ece1779.amazon.ImageUploader" %>
<%@ page import="ca.utoronto.ece1779.database.User" %>

<%
	String imageidstr = request.getParameter("imageid");
	int imageid = Integer.parseInt(imageidstr);
	// Get the image
	String key0 = "";
	String key1 = "";
	String key2 = "";
	String key3 = "";
        String bucket = ImageUploader.BUCKET;
	for (Image im : Image.getAllImages()){
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
        <link href="../css/signin.css" rel="stylesheet">
   		<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>

	<jsp:include page="includes/header.jsp" />

	<body>

    <div class="container">
       <h1 class="text-center">Image <%= imageidstr %></h1>

        <div class="row" style="margin: 0 auto;">
        <div class="col-md-12">
            <table class="table">
                <tr>
                    <th class="text-center">Original:</th>
                </tr>
                <tr>
                    <td><img class="center-block" style="max-width:800px;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key0 %>" /></td>
                </tr>
                <tr>
                    <th class="text-center">Transform 1:</th>
                </tr>
                <tr>
                    <td><img class="center-block" style="max-width:800px;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key1 %>" /></td>
                </tr>
                <tr>
                    <th class="text-center">Transform 2:</th>
                </tr>
                <tr>
                    <td><img class="center-block" style="max-width:800px;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key2 %>" /></td>
                </tr>
                <tr>
                    <th class="text-center">Transform 3:</th>
                </tr>
                <tr>
                    <td><img class="center-block" style="max-width:800px; float: center;" src="http://<%= bucket %>.s3-us-west-2.amazonaws.com/<%= key3 %>" /></td>
                </tr>

            </table>

        </div>
    </div>
    </div>

	</body>

</html>
