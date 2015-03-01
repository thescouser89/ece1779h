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
		<script>
		</script>
	</head>

	<jsp:include page="includes/header.jsp" />
	
	<body>

    <div>
      <h1>My Images</h1>
    </div> 

	<div style="width:500px;padding:0px;">
		<!--%
			for (int i=0; i < imageArray.length; i++)
			{
		%-->
		
		<%
			if (session.getAttribute("username") != null)
			for (Image im : Image.findImagesWithUserId(User.findUser(username).getId())){
				out.println("<a href='/ece1779/jsp/view_image.jsp?imageid="+im.getId()+"'><img style='max-width:100px;max-height:75px;float:left;' src='http://" + bucket + ".s3-us-west-2.amazonaws.com/"+im.getOriginalImage()+"' /></a>");
			}
		%>
			
		<!--%
			}
		%-->
	</div>
	
	</body>

</html>
