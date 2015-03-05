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
	if (session.getAttribute("username") != null){
		String username = (String) session.getAttribute("username");
		session.setAttribute("user_id_str", Integer.toString(User.findUser(username).getId()));
	}
	
	// If post request to upload
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		try {
			int user_id = -1;
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
                } else if (item.getFieldName().equals("userID")){
					user_id = Integer.parseInt(item.getString());
				}
            }
			
			// get root directory of web application, random file name
			String path = this.getServletContext().getRealPath("/");        
			String key1 = "/temp_images/MyObjectKey_" + UUID.randomUUID();
			String filepath = path+key1;
			
			
			// store file in server
			File file1 = new File(filepath); 
			theFile.write(file1);
			
			ImageHelper ih = new ImageHelper(user_id,filepath); 
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
        <script>
		function validateForm(){
			if (document.getElementById("my-file-selector").value == ''){
				alert("Please select a file.");
				return false;
			}
			return true;
		}
	</script>
	</head>

	<jsp:include page="/jsp/includes/header.jsp" />

	<body>
	<div class="container">
            <!-- Display filename inside the button instead of its label -->
        <form class="form-signin" action="/ece1779/servlet/FileUpload"  enctype="multipart/form-data" method="post" onsubmit="return validateForm();">
            <h1 class="form-signin-heading">Upload Image</h1>
            <input type="hidden" name="userID" value="${user_id_str}" id="id_userID"><br />

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
