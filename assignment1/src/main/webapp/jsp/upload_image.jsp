<%@ page import="ca.utoronto.ece1779.database.User" %>
<%@ page import="ca.utoronto.ece1779.images.ImageHelper" %>
<%@ page import="ca.utoronto.ece1779.database.Image" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.*" %>

<%
	// If not logged in, redirect to login
	//if (session.getAttribute("username") == null){
	//	response.sendRedirect("login.jsp");
	//}
	String username = "";
	if (session.getAttribute("username") != null){
		username = (String) session.getAttribute("username");
	}

	// If post request to upload
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		try {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			// Parse the request
			List /* FileItem */ items = upload.parseRequest(request);

			FileItem theFile = null;

			// Parse the request
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                    theFile = item;
					break;
                }
            }

			// get root directory of web application, random file name
			String path = this.getServletContext().getRealPath("/");
			File theDir = new File(path + "/temp_images");
			if (!theDir.exists()) {
			    theDir.mkdir();
			}
			String key1 = "/temp_images/MyObjectKey_" + UUID.randomUUID();
			String filepath = path+key1;


			// store file in server
			File file1 = new File(filepath);
			theFile.write(file1);

			ImageHelper ih = new ImageHelper(User.findUser(username).getId(),filepath);
			int imageid = ih.uploadImagesToS3AndSaveToDatabase();

			response.sendRedirect("/ece1779/jsp/view_image.jsp?imageid="+imageid);

		} catch (Exception ex) {
			out.println("something went wrong");
			throw new ServletException (ex);
		} finally {
		}
	}

%>

<!DOCTYPE html>
<html>
	<head>
		<title>Upload Image</title>
		<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE" />
		<meta charset="utf-8">
    	<!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <link href="../css/signin.css" rel="stylesheet">
        <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>

	<jsp:include page="/jsp/includes/header.jsp" />

	<body>
	<div class="container">
            <!-- Display filename inside the button instead of its label -->
        <form class="form-signin" action="/ece1779/servlet/FileUpload"  enctype="multipart/form-data" method="post">
            <h1 class="form-signin-heading">Upload Image</h1>
            <input type="hidden" name="userID" value="${username}"><br />

            <label id="label_file" class="btn btn-default btn-lg btn-block" for="my-file-selector">
                <input id="my-file-selector" type="file" name="theFile" style="display:none;" onchange="$(this).parent().parent().parent().find('#label_file_replace').text($(this).val());">
                <span id="label_file_replace">Browse</span>
            </label>

            <button class="btn btn-lg btn-primary btn-block" type="submit">Upload Image</button>
            <button class="btn btn-lg btn-danger btn-block" type="reset" onclick="$('#label_file_replace').text('Browse');">Reset</button>
        </form>
    </div>
  </body>

</html>
